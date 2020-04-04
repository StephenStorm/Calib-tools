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

%%compute the distortion of center
%using all chessboard points
% x1d=p2(cb2(tt),2)';
% y1d=p2(cb2(tt),1)';
% x1=X(tt);
% y1=Y(tt);
xs=[X(:)';Y(:)';ones(1,length(X(:)))];
xsd=[p2(cb2(:),2)';p2(cb2(:),1)';ones(1,length(X(:)))];

% xs=[x1;y1;ones(1,length(x1))];
% xsd=[x1d;y1d;ones(1,length(x1d))];

F=det_F_normalized_8point(xs,xsd);
[e,eprime]= get_epipole(F);
DoC=eprime/eprime(3);

display('The distortion of center is:')
round([DoC(1) DoC(2)])

figure
imshow(img_dis)
hold on
plot(DoC(2),DoC(1),'r*');
% xx=round([DoC(2) DoC(1)])
text(DoC(2),DoC(1),' Center of Distortion','FontSize',15,'color',[1 0 0]);  
hold off

%%error
[m n t]=size(img_dis);
% DoC(1:2)-[m/2 n/2]'
clear xs xsd
