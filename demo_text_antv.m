% t-ANTV for blind deblurring
% dataset text of Pan et al. 
%% set parameters
clc
clear 
close all;

addpath(genpath('cho_code'));
addpath(genpath('t_antv/'));

%% read file

for img_index = 1
    for k_index = 1

        if img_index <=9 
            filename = strcat('blurred_images/im0',num2str(img_index),'_ker0',num2str(k_index),'_blur.png');
        else
            filename = strcat('blurred_images/im',num2str(img_index),'_ker0',num2str(k_index),'_blur.png');
        end   
        kernel_size = 21;  % various for different kernels
        saturation = 0;
        lambda_1 = 4e-3;    % for L0 gradient regularization
        lambda_2 = 3e-3;    % for t-ANTV regularization
        lambda_tv = 0.001; lambda_l0 = 5e-4; weight_ring = 0;
        
        refname = strcat('gt_images/',filename(16:19),'.png');
        ref = imread(refname);
        ref = im2double(ref);
        
        save_name = filename(16:25);

        y = imread(filename);

%% pre-processing
isselect = 0; %false or true
if isselect ==1
    figure, imshow(y);
    fprintf('Please choose the area for deblurring:\n');
    h = imrect;
    position = wait(h);
    close;
    B_patch = imcrop(y,position);
    y = (B_patch);
else
    y = im2double(y);
end
if size(y,3)==3
    yg = im2double(rgb2gray(y));
else
    yg = im2double(y);
end


%% for different p
    tic;
    [kernel, interim_latent] = blind_deconv_low_rank(y, yg, lambda_1, lambda_2, kernel_size);
    toc
    y = im2double(y);
    
    %% Final Deblur: 
    if ~saturation
    %% 1. TV-L2 denoising method
        Latent = ringing_artifacts_removal(y, kernel, lambda_tv, lambda_l0, weight_ring);
    else
    %% 2. Whyte's deconvolution method (For saturated images)
        Latent = whyte_deconv(y, kernel);
    end
    Latent = im2double(Latent);
%% get PSNR      
   
    res = Latent - ref;
    [psnr1, snr] = psnr(max(min(Latent,1),0), ref,1);
%     ssim1 = ssim(Latent,ref);
    disp(psnr1)
%     figure; imshow(Latent)

%%
    k = kernel - min(kernel(:));
    k = k./max(k(:));
    
    %% record
    n1 = ['results_text','/'];
    n2 = [filename(16:25)];

    recname_k = strcat(n1,n2,strcat('/k_',[]),'.png');
    recname_interim = strcat(n1,n2,strcat('/inter_',[]),'.png');
    recname_Latent = strcat(n1,n2,strcat('/Latent_',[]),'.png');
    recname_res = strcat(n1,n2,strcat('/res_',[]),'.png');

    if exist([n1,n2],'dir') == 0
        mkdir('results_text/',n2);
    end
    
    imwrite(k,[strcat(recname_k)]);
    imwrite(interim_latent,[strcat(recname_interim)]);
    imwrite(Latent,[strcat(recname_Latent)]);
    imwrite(res,[strcat(recname_res)])
    
    end
end
