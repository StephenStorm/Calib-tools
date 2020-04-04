% Copyright (c) 2014, Xianghua Ying
% All rights reserved.
% SWARD Camera Calibration Toolbox
% Vision:2.2
% Author:  Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, 2014/10/08
% Notes: 
%- This toolbox is designed for radial lens distortion correction from a single image of a planar pattern.
%- This toolbox uses the LIBCBDETECT codes in the 'matching' folder to extract chessboard corners autmatically. You can download the LIBCBDETECT codes from http://www.cvlibs.net/software/libcbdetect/. 
%- You can run this toolbox from the script file of 'main_gui.m'.
%- If you use this code, please refer(use) the references:
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Hongbin Zha, Radial distortion correction from a single image of a planar calibration pattern using convex optimization, IEEE International Conference on Image Processing (ICIP), 2014
%- Xianghua Ying, Xiang Mei, Sen Yang, Ganwen Wang, Jiangpeng Rong, Hongbin Zha, Imposing Differential Constraints on Radial Distortion Correction, the 12th Asian Conference on Computer Vision (ACCV'14), 2014.
%- Please for any help send to us: xhying@cis.pku.edu.cn

[cm cn]=size(cb2);

%vanishing point1: two distortion line points
ln1=round(cm/2+cm*0.2);
ln2=round(cm/2-cm*0.2);

ln1n=cb2(ln1,:);
ln2n=cb2(ln2,:);

lp1=corners2.p(ln1n,:)-centerX;
lp2=corners2.p(ln2n,:)-centerY;

 lp1c=zeros(size(lp1));
 lp2c=zeros(size(lp2));
 
  tt11=1+rlamda*(lp1(:,1).^2+lp1(:,2).^2);
  lp1c(:,1)=lp1(:,1)./tt11;
  lp1c(:,2)=lp1(:,2)./tt11;
  
  tt12=1+rlamda*(lp2(:,1).^2+lp2(:,2).^2);
  lp2c(:,1)=lp2(:,1)./tt12;
  lp2c(:,2)=lp2(:,2)./tt12;

l1=polyfit(lp1c(:,1),lp1c(:,2),1);
l2=polyfit(lp2c(:,1),lp2c(:,2),1);

pp1x=-(l1(2)-l2(2))/(l1(1)-l2(1));
pp1y=l1(1)*pp1x+l1(2);


%brreak
%vanishing point2: two distortion line points
vn1=round(cn/2+cn*0.2);
vn2=round(cn/2-cn*0.2);

vn1n=cb2(:,vn1);
vn2n=cb2(:,vn2);

vp1=corners2.p(vn1n,:)-centerX;
vp2=corners2.p(vn2n,:)-centerY;

 vp1c=zeros(size(vp1));
 vp2c=zeros(size(vp2));
 
%   tt12=1+rlamda*(vp1(:,1).^2+vp1(:,2).^2);
%  vp1c(:,1)=vp1(:,1)./tt2;
%  vp1c(:,2)=vp1(:,2)./tt2;
 
  tt21=1+rlamda*(vp1(:,1).^2+vp1(:,2).^2);
 vp1c(:,1)=vp1(:,1)./tt21;
  vp1c(:,2)=vp1(:,2)./tt21;
  
  tt22=1+rlamda*(vp2(:,1).^2+vp2(:,2).^2);
  vp2c(:,1)=vp2(:,1)./tt22;
 vp2c(:,2)=vp2(:,2)./tt22;
 

l1=polyfit(vp1c(:,1),vp1c(:,2),1);
l2=polyfit(vp2c(:,1),vp2c(:,2),1);

pp2x=-(l1(2)-l2(2))/(l1(1)-l2(1));
pp2y=l1(1)*pp2x+l1(2);

%two points (pp1x,pp1y)  (pp2x,pp2y)
pp1Q=[pp1x,pp1y];
pp2Q=[pp2x,pp2y];

%P-点坐标　Q1, Q2线上两点坐标
P=[0 0];
dpv= abs(det([pp2Q'-pp1Q',P'-pp1Q']))/norm(pp2Q-pp1Q);
dpQ1=norm(pp1Q);
dpQ2=norm(pp2Q);

%sqrt(dpQ1^2-dpv^2)
dov=sqrt( sqrt(dpQ1^2-dpv^2)*sqrt(dpQ2^2-dpv^2));
ff=sqrt(dov^2-dpv^2)

fid=fopen('.\output\camera_parameter.txt','wt');%写入文件路径
%fprintf(fid,'Input image size \n%g\n',size(img_dis));
fprintf(fid,'Camera distortion center (centerX,centerY)=\n%g, %g\n',centerX,centerY);
fprintf(fid,'Camera distortion parameter k1 =\n%g\n',rlamda);
fprintf(fid,'Camera focus length f =\n%g\n',ff);
fclose(fid);







