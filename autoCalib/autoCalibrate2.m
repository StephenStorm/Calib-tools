clear variables; dbstop error; close all;
disp('================================');

addpath('matching');
addpath('ocam_calib');
tau = 0.08;

para_img = {'./img/20190818/front.jpg','img/20190818/right.jpg','./img/20190818/rear.jpg','img/20190818/left.jpg'};
%para_img = {'./img/front_1.jpg','img/right_1.jpg','./img/rear_1.jpg','img/left_0.jpg'};
para_pos = {'calib_model/front_pos.txt','calib_model/lr_pos.txt'};
para_calib = {'calib_model/calibFrontStandard.mat','calib_model/calibLeftStandard.mat'};

para_demo_img = {'./img/Demo/front_test.bmp','img/Demo/right_0.jpg','img/Demo/rear.jpg','img/Demo/left_0.jpg'};

mat_out_file = {'calib_results/front_calib_results.mat','calib_results/right_calib_results.mat','calib_results/rear_calib_results.mat','calib_results/left_calib_results.mat'};

txt_out_file = {'calib_results/front_results.txt','calib_results/right_results.txt','calib_results/rear_results.txt','calib_results/left_results.txt'};

for  i=1:4
    I = imread(para_demo_img{i});
    %I = imread(para_img{i});
    corners = findCorners(I,tau,1);
    chessboards = chessboardsFromCorners(corners);
     I = rgb2gray(I);
    if length(chessboards) ~= 1
        disp('chessboard auto dectiect error');
        return;
    end;
    cb = chessboards{1};
    %%debug
    figure; imshow(uint8(I));
    impixelinfo;
    hold on;
    scatter(corners.p(:,1),corners.p(:,2),'r','filled');
    
    
    [m,n] = size(cb);
    if  n==3
        disp('chessboard oritentation error');
        return;
    end
    
    if i>2
        idx = i-2;
    else
        idx = i;
    end
    calib_tmp = load(para_calib{idx});
    calib_tmp = calib_tmp.calib_data;
    calib_tmp.Xp_abs = [];
    calib_tmp.Yp_abs = [];
    calib_tmp.I{1} = I;
    %取出棋盘格角点坐标
    for j=1:size(cb,1)
        p = corners.p(cb(j,:),:);
        calib_tmp.Xp_abs = [calib_tmp.Xp_abs;p(:,2)];
        calib_tmp.Yp_abs = [calib_tmp.Yp_abs;p(:,1)];
    end
        
    %标定
    calibration(calib_tmp);
    
    %查找图像的中心
    findcenter(calib_tmp);
    %refinement
    optimizefunction(calib_tmp);
    %保存标定结果  .mat
    saving_calib(calib_tmp,mat_out_file{i});
    %保存txt文件
    exportData2TXT(calib_tmp,txt_out_file{i});
end


for i=1:4
        calib_tmp = load(mat_out_file{i});
        calib_tmp = calib_tmp.calib_data;
        reproject_calib(calib_tmp);
        res = input('press any key');
end


        
    

