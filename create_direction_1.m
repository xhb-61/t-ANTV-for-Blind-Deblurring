clear
clc
% dataname = 'Levin';
% dataname = 'kohler';
% dataname = 'Sun';
% dataname = 'text';
% dataname = 'saturated';
% dataname = 'text_binary';
% dataname = 'text_binary2';
% dataname = 'binary';
% dataname = 'cp';
% dataname = 'text_low_rank';
% dataname = 'text_SCAD';
% dataname = 'kohler_lr';
% dataname = 'saturate_lr';
% dataname = 'lai_lr';
% dataname = 'lai-lr-2';
% dataname = 'levin-lr';
% dataname = 'text_lp';
% dataname = 'kohler_lp';
dataname = 'saturate_lp';
switch dataname
    case 'Levin'
        for img_index = 5:8
            for k_index = 1:8 
                save_name = ['im0',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_Levin\',save_name);
                mkdir(strcat('results_Levin\',save_name,'\'),'temp');

            end
        end
        
    case 'kohler'
        for img_index = 1:4
            for k_index = 1:12
                save_name = ['im0',num2str(img_index),'_ker',num2str(k_index)];
                mkdir('results_kohler\',save_name);
                mkdir(strcat('results_kohler\',save_name,'\'),'temp');
            end
        end
        
    case 'Sun'
        for img_index = 1:80
            for k_index = 1:8
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_Sun\',save_name);
                mkdir(strcat('results_Sun\',save_name,'\'),'temp');
            end
        end
        
    case 'text'
        for img_index = 1:15
            for k_index = 1:8
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_text\',save_name);
                mkdir(strcat('results_text\',save_name,'\'),'temp');
            end
        end
    case 'saturated'
        for img_index = 1:6
            for k_index = 1:8 
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_smooth_new\saturated',save_name);
                mkdir(strcat('results_My\results_smooth_new\saturated\',save_name,'\'),'temp');
            end
        end
    case 'text_binary'
        for img_index = 1:15
            for k_index = 1:8 
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_binary\',save_name);
                mkdir(strcat('results_My\results_binary\',save_name,'\'),'temp');
            end
        end
    case 'text_binary2'
        for img_index = 1:15
            for k_index = 1:8 
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_binary_SR\',save_name);
                mkdir(strcat('results_My\results_binary_SR\',save_name,'\'),'temp');
            end
        end
    case 'binary'
        for img_index = 43:108
            for k_index = 1:8 
                save_name = ['binary_',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_binarydataset_4d\',save_name);
                mkdir(strcat('results_My\results_binarydataset_4d\',save_name,'\'),'temp');
            end
        end
    case 'cp'
        for img_index = 3:7
            for k_index = 1:8 
                save_name = ['cp_',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_cp_SR\',save_name);
                mkdir(strcat('results_My\results_cp_SR\',save_name,'\'),'temp');
            end
        end
    case 'text_low_rank'
        for img_index = 1:9
            for k_index = 1:8 
                save_name = ['im0',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_low_rank\text',save_name);
                mkdir(strcat('results_My\results_low_rank\text\',save_name,'\'),'temp');
            end
        end
        for img_index = 10:15
            for k_index = 1:8 
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_low_rank\text',save_name);
                mkdir(strcat('results_My\results_low_rank\text\',save_name,'\'),'temp');
            end
        end
    case 'text_SCAD'
        for img_index = 1:9
            for k_index = 1:8 
                save_name = ['im0',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_SCAD\text',save_name);
                mkdir(strcat('results_My\results_SCAD\text\',save_name,'\'),'temp');
            end
        end
        for img_index = 10:15
            for k_index = 1:8 
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_SCAD\text',save_name);
                mkdir(strcat('results_My\results_SCAD\text\',save_name,'\'),'temp');
            end
        end
    case 'kohler_lr'
        for img_index = 1:4
            for k_index = 1:12
                save_name = ['im',num2str(img_index),'_ker',num2str(k_index)];
                mkdir('results_My\results_low_rank\kohler',save_name);
                mkdir(strcat('results_My\results_low_rank\kohler\',save_name,'\'),'temp');
            end
        end
    case 'saturate_lr'
        for img_index = 1:6
            for k_index = 1:8
                save_name = ['im0',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_low_rank\saturate',save_name);
                mkdir(strcat('results_My\results_low_rank\saturate\',save_name,'\'),'temp');
            end
        end
    case 'lai_lr'
        class = {'manmade','natural','people','saturated','text'};
        for classname = class
        for img_index = 1:5
            for k_index = 1:4
                save_name = [classname{1},'_0',num2str(img_index),'_kernel_0',num2str(k_index)];
                mkdir('results_My\results_low_rank\lai',save_name);
                mkdir(strcat('results_My\results_low_rank\lai\',save_name,'\'),'temp');
            end
        end
        end
    case 'lai-lr-2'
        for img_index = 1:25
            for k_index = 1:4
                save_name = [num2str(img_index),'_kernel_0',num2str(k_index)];
                mkdir('results_My\results_low_rank\lai-2',save_name);
                mkdir(strcat('results_My\results_low_rank\lai-2\',save_name,'\'),'temp');
            end
        end
    case 'levin-lr'
        for img_index = 5:8
            for k_index = 1:8 
                save_name = ['im0',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_low_rank\levin',save_name);
                mkdir(strcat('results_My\results_low_rank\levin\',save_name,'\'),'temp');

            end
        end

    case 'text_lp'
        for img_index = 1:15
            for k_index = 1:8
                save_name = ['im',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My\results_smooth_lp\text',save_name);
                mkdir(strcat('results_My\results_smooth_lp\text\',save_name,'\'),'temp');
            end
        end
    case 'kohler_lp'
        for img_index = 1:4
            for k_index = 1:12
                save_name = ['im',num2str(img_index),'_ker',num2str(k_index)];
                mkdir('results_My/results_smooth_lp/kohler',save_name);
                mkdir(strcat('results_My/results_smooth_lp/kohler/',save_name,'/'),'temp');
            end
        end
    case 'saturate_lp'
        for img_index = 1:6
            for k_index = 1:8
                save_name = ['im0',num2str(img_index),'_ker0',num2str(k_index)];
                mkdir('results_My/results_smooth_lp/saturate',save_name);
                mkdir(strcat('results_My/results_smooth_lp/saturate/',save_name,'/'),'temp');
            end
        end
end
