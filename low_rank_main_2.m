function S = low_rank_main_2(Ic, Im, kernel, wei_grad1, wei_grad2, kappa)
%% The fast implementation with GPU type
% Image restoration with L0 regularized gradient prior and t-ANTV prior

%% Input:
% Im: Blurred image
% kernel: blur kernel
% wei_grad1: weight for the L0 gradient prior
% wei_grad2: weight for the t-ANTV prior
% kappa: Update ratio in the ADM
%% Output:
% S: Latent image

if ~exist('kappa','var')
    kappa = 2.0;
end

%%
S = Ic;
betamax2 = 1e4;
fx = [1, -1];
fy = [1; -1];
[N,M,D] = size(Ic);
sizeI2D = [N,M];
otfFx = psf2otf(fx,sizeI2D);
otfFy = psf2otf(fy,sizeI2D);

%%
KER = psf2otf(kernel,sizeI2D);
Den_KER = abs(KER).^2;
%%
Denormin2 = abs(otfFx).^2 + abs(otfFy ).^2;
if D>1
    Denormin2 = repmat(Denormin2,[1,1,D]);
    KER = repmat(KER,[1,1,D]);
    Den_KER = repmat(Den_KER,[1,1,D]);
end

Sgpu = S;
FFTSgpu = fft2(Sgpu);
FSgpu = gather(FFTSgpu);
Normin1 = conj(KER).*FSgpu;
Normin1gpu = Normin1;
Den_KERgpu = Den_KER;
Denormin2gpu = Denormin2;

%% First gradient sub-problem
beta1 = 2*wei_grad1;
betamax1 = 2^3;

while beta1 < betamax1
    %% first gradient sub-problem 
    % L0 problem
    h1 = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
    v1 = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
    
    if D==1
           t = (h1.^2+v1.^2)<wei_grad1/beta1;
    else
            t = sum((h1.^2+v1.^2),3)<wei_grad1/beta1;
            t = repmat(t,[1,1,D]);
    end
    h1(t)=0; v1(t)=0;
    clear t;

    %% Second Gradient sub-problem
    beta2 = 2*wei_grad2;
    while beta2 < betamax2
        Denormingpu = Den_KERgpu + beta1*Denormin2gpu + beta2*Denormin2gpu;

        % h-v subproblem 
        h2 = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
        v2 = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
        
        [h2,~,~] = prox_htnn_C_4(h2,wei_grad2/beta2); 
        [v2,~,~] = prox_htnn_C_4(v2,wei_grad2/beta2);
            
        % S subproblem
        Normin_2 = [h2(:,end,:) - h2(:, 1,:), -diff(h2,1,2)];
        Normin_2 = Normin_2 + [v2(end,:,:) - v2(1, :,:); -diff(v2,1,1)];

        %% With following code for acceleration
        Normin2gpu2 = Normin_2;
        Normin2fft2 = (fft2(Normin2gpu2));
        Normin_1 = [h1(:,end,:) - h1(:, 1,:), -diff(h1,1,2)];
        Normin_1 = Normin_1 + [v1(end,:,:) - v1(1, :,:); -diff(v1,1,1)];
        Normin2gpu1 = Normin_1;
        Normin2fft1 = (fft2(Normin2gpu1));
        FSgpu = (Normin1gpu + beta2*Normin2fft2 + beta1*Normin2fft1)./Denormingpu;

        S = real(ifft2(FSgpu));
        S = (gather(S));
        beta2 = beta2*kappa;

        if wei_grad2==0
            break;
        end
    end
    beta1 = beta1*kappa;
end

end