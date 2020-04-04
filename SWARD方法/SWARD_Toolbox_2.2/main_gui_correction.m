% Copyright (c) 2014, Xianghua Ying
% All rights reserved.
% SWARD Camera Calibration Toolbox
% Vision: 2.2
% Author:  Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, 2014/10/08
% Notes: 
%- This toolbox is designed for radial lens distortion correction from a single image of a planar pattern.
%- This toolbox uses the LIBCBDETECT codes in the 'matching' folder to extract chessboard corners autmatically. You can download the LIBCBDETECT codes from http://www.cvlibs.net/software/libcbdetect/. 
%- You can run this toolbox from the script file of 'main_gui.m'.
%- If you use this code, please refer(use) the references:
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Hongbin Zha, Radial distortion correction from a single image of a planar calibration pattern using convex optimization, IEEE International Conference on Image Processing (ICIP), 2014
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, Imposing Differential Constraints on Radial Distortion Correction, the 12th Asian Conference on Computer Vision (ACCV'14), 2014.
%- Please for any help send to us: xhying@cis.pku.edu.cn

close all;clear all;clc
%%gui
warning('off');

cell_list = {};

fig_number = 1;
title_figure ='SWARD Camera Calibration Toolbox--New Input Image Correction';

cell_list{1,1} = {'Image Input', 'Img_read;'};
cell_list{1,2} = {'Load camera parameter', 'Parameter_load;'};
cell_list{1,3} = {'Distortion Correct', 'Distortion_Correct_new;'};
cell_list{1,4} = {'Save', 'Img_save_cor;'};
cell_list{1,5} ={'Quit', ['disp(''To run again, type main_gui.''); close(' num2str(fig_number) ');']};

% show_window(cell_list,fig_number,title_figure,120,18,0,'clean',12);
show_window(cell_list,fig_number,title_figure,135,25,0,'clean',12);
