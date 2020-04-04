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

%%correct the distorted image
It2 = img_dis; %RGB
% It2 = rgb2gray(img_dis);%gray

%size of the distortion image
[ms ns t]=size(It2);

%new iamge size
ttt=1+rlamda*((ms/2)^2+(ns/2)^2) %%The largest magnification
if(ttt>1)
    mc=ms;
    nc=ns;
elseif(ttt<0.3)
    mc=ms*4;
    nc=ns*4;
else
    mc=round(ms/ttt);
    nc=round(ns/ttt);
end

IR=ones(mc, nc,3);
% cx=mc/2;
% cy=nc/2;
cx=mc*centerX/ms;
cy=nc*centerY/ns;

% the distortion parameter of the  division model
k=rlamda;

[m,n,t11]=size(IR);

for ii=1:m
    for jj=1:n
        
        tx=ii-cx;
        ty=jj-cy;
        tR=(tx)^2+(ty)^2;
        s=(1-sqrt(1-4*k*tR))/(2*k*tR);%the distortion parameter for every point
        
        x=round(tx*s+centerX);
        y=round(ty*s+centerY);
        
        if(x>0 & y>0&x<ms+1&y<ns+1)
            IR(ii,jj,:)=It2(x,y,:);%RGB
            %IR(ii,jj)=It2(x,y);    %Gray
        end
    end
end

% IR=round(IR);
IR=uint8(IR);

%the corrected image
figure
imshow(IR)

