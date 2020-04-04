% Copyright (c) 2014, Xianghua Ying
% All rights reserved.
% SWARD Camera Calibration Toolbox
% Vision:2.2
% Author:  Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, 2014/10/08
% Notes: 
%- This toolbox is designed for radial lens distortion correction from a single image of a planar pattern.
%- This toolbox uses the LIBCBDETECT codes in the 'matching' folder to extract chessboard corners autmatically. You can download the LIBCBDETECT codes from http://www.cvlibs.net/software/libcbdetect/. 
%- The SWARD Camera Calibration Toolbox can be divided into two parts. The first part of the toolbox (the start script is ¡®main_gui_calibration.m¡¯) is used for radial lens distortion calibration from a single image of a planar pattern. The second part of the toolbox (the start script is ¡®main_gui_correction.m¡¯) is used to correct a new distortion image with the same camera.
%- If you use this code, please refer(use) the references:
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Hongbin Zha, Radial distortion correction from a single image of a planar calibration pattern using convex optimization, IEEE International Conference on Image Processing (ICIP), 2014
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, Imposing Differential Constraints on Radial Distortion Correction, the 12th Asian Conference on Computer Vision (ACCV'14), 2014.
%- Please for any help send to us: xhying@cis.pku.edu.cn