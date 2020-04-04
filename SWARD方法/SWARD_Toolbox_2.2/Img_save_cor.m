% Copyright (c) 2014, Xianghua Ying
% All rights reserved.
% SWARD Camera Calibration Toolbox
% Vision:1.0
% Author:  Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, 2014/10/08
% Notes: 
%- This toolbox is designed for radial lens distortion correction from a single image of a planar pattern.
%- This toolbox uses the LIBCBDETECT codes in the 'matching' folder to extract chessboard corners autmatically. You can download the LIBCBDETECT codes from http://www.cvlibs.net/software/libcbdetect/. 
%- You can run this toolbox from the script file of 'main_gui.m'.
%- If you use this code, please refer(use) the references:
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Hongbin Zha, Radial distortion correction from a single image of a planar calibration pattern using convex optimization, IEEE International Conference on Image Processing (ICIP), 2014
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, Imposing Differential Constraints on Radial Distortion Correction, the 12th Asian Conference on Computer Vision (ACCV'14), 2014.
%- Please for any help send to us: xhying@cis.pku.edu.cn


%%save the corrected image
Sp=regexp(filename,'\.', 'split');
filenamet=Sp{1};
filenamet=['.\output\'  filenamet ];
img_suffix=Sp{2};
nameofcor=[filenamet  '_c' '.' img_suffix];

IR1_gray=rgb2gray(IR);
rgb_size=size(img_dis);
IR1=imresize(IR1_gray,rgb_size(1:2));
imwrite(IR1,nameofcor);
% imwrite(IR,nameofcor);
%save camera distortion parameter
% save ./output/data.mat  centerX centerY rlamda
% load ./output/data.mat



