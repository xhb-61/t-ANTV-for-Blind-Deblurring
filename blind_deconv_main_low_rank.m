function [k, lambda_1, lambda_2, S] = blind_deconv_main_low_rank(blur_B_c, blur_B, k, ...
                                    lambda_1, lambda_2, threshold)
% Do single-scale blind deconvolution using the input initializations

%% Input:
% blur_B: input blurred image 
% k: blur kernel
% lambda_1: the weight for the L0 regularization on gradient
% lambda_2: the weight for t-ANTV regularization on gradient
%
% Ouput:
% k: estimated blur kernel 
% S: intermediate latent image
%

%=====================================
xk_iter = 5;
% derivative filters
dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H = size(blur_B,1);    W = size(blur_B,2);
blur_B_c_pad = wrap_boundary_liu(blur_B_c, opt_fft_size([H W]+size(k)-1));
blur_B_w = wrap_boundary_liu(blur_B, opt_fft_size([H W]+size(k)-1));
blur_B_tmp = blur_B_w(1:H,1:W,:);
Bx = conv2(blur_B_tmp, dx, 'valid');
By = conv2(blur_B_tmp, dy, 'valid');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
for iter = 1:xk_iter

   %% 
  S = low_rank_main_2(blur_B_c_pad, blur_B_w, k, lambda_1, lambda_2, 2.0);
  S = S(1:H,1:W,:);


  [~,~,D] = size(S);
  if D == 1
    [latent_x, latent_y, threshold]= threshold_pxpy_v1(S,max(size(k)),threshold); 
  else
    [latent_x, latent_y, threshold]= threshold_pxpy_v1(rgb2gray(S),max(size(k)),threshold);   
  end

  k_prev = k;
  %% using FFT method for estimating kernel 
  k = estimate_psf(Bx, By, latent_x, latent_y, 2, size(k_prev));
  %%
  fprintf('pruning isolated noise in kernel...\n');
  CC = bwconncomp(k,8);
  for ii=1:CC.NumObjects
      currsum=sum(k(CC.PixelIdxList{ii}));
      if currsum<.1 
          k(CC.PixelIdxList{ii}) = 0;
      end
  end
  k(k<0) = 0;
  k=k/sum(k(:));
  %%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Parameter updating
  if lambda_1~=0
      lambda_1 = max(lambda_1/1.1, 1e-4);
  else
      lambda_1 = 0;
  end

  if lambda_2~=0
      lambda_2 = max(lambda_2/1.1, 1e-4);
  else
      lambda_2 = 0;
  end

  S(S<0) = 0;
  S(S>1) = 1;
  

%% show inter results     
    figure(1); 
  subplot(1,3,1); imshow(blur_B_c,[]); title('Blurred image');
  subplot(1,3,2); imshow(S,[]);title('Interim latent image');
  subplot(1,3,3); imshow(k,[]);title('Estimated kernel');
  
  
  %% kernel   
  k(k<0) = 0;  
  k = k ./ sum(k(:));

end
end


