
clear variables; dbstop error; close all;
disp('================================');

addpath('matching');
addpath('ocam_calib');
tau = 0.01;

[fM,lM] = reProject;
para_front = {'./img/front_1.jpg','./img/rear_1.jpg'};
para_left = {'./img/left_1.jpg','./img/right_1.jpg'};


mat_file1 = {'calib_results/front_calib_results.mat','calib_results/rear_calib_results.mat'};
mat_file2 = {'calib_results/left_calib_results.mat','calib_results/right_calib_results.mat'}; 
txt_file1 = {'calib_results/front_results.txt','calib_results/rear_results.txt'};
txt_file2 = {'calib_results/left_results.txt','calib_results/right_results.txt'};
for i=1:2
    I = imread(para_front{i});
    corners = findCorners(I,tau,1);
    p = corners.p;
    p(:, [1 2]) = p(:,[2 1]);
    pre = fM(:,:,i);
    pre = pre';
    res = assignClosestCorners(p+1,pre);
    calib_tmp = load('./calib_result/calib0.mat');
    calib_tmp = calib_tmp.calib_data;
    calib_tmp.Xp_abs = res(1,:)';
    calib_tmp.Yp_abs = res(2,:)';
    %标定
%     disp('start calibration\n');
    calibration(calib_tmp);
    
    %查找图像的中心
    findcenter(calib_tmp);
    %refinement
    optimizefunction(calib_tmp);
    %保存标定结果  .mat
    saving_calib(calib_tmp,mat_file1{i});
    %保存txt文件
    exportData2TXT(calib_tmp,txt_file1{i});
end