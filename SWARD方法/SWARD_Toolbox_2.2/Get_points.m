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

% disp('===============Corner detection automatically=================');
folder='matching';
if ~isdir(folder) 
    disp('Notice:  As the ''matching'' folder does not exist, the program can not run!')
    disp('If you want to run it, you should download the folder from  the first reference link of our website and put it in the current folder.  ');
    %break;
end
   
addpath(folder);

% I1= img_chess;
I2= img_dis;

%%Corner detection automatically
% tic
corners2 = findCorners(I2,0.01,1);
chessboards2 = chessboardsFromCorners(corners2);

cb2=chessboards2{1,1};
p2=corners2.p+1;
% toc

%%s
[cm cn]=size(cb2);
% [pm pn,pt]=size(I2);
c1 = p2(cb2(1,1),:);
center = p2( cb2( round(cm/2) , round(cn/2) ) ,:);
c1s=c1-center;

if c1s(1)<0&&c1s(2)>0
    cb2=rot90(cb2,-1);
elseif c1s(1)>0&&c1s(2)>0
    cb2=rot90(cb2,-2);
elseif c1s(1)>0&&c1s(2)<0
    cb2=rot90(cb2,1);
end

[cm cn]=size(cb2);

%%display the detected points
figure; imshow(uint8(I2)); hold on;
cb2t=cb2(:);
p2t = corners2.p(cb2t,:)+1;
for mm=1:length(p2t)
    plot(p2t(mm,1),p2t(mm,2),'r*');
 end


%%generate chessboard automatically
[XX,YY] = meshgrid(1:1:cm, 1:1:cn);  
X=XX';
Y=YY';

%set the number of   points
if cm*cn<50
    POINTS=0.5*cm*cn;
else
    POINTS=0.3*cm*cn;
end
POINTS=round(POINTS);
%Randomly select
while(1)
    xnum=round(rand(1,POINTS)*(cm-1))+1;
    ynum=round(rand(1,POINTS)*(cn-1))+1;
    tt=cm*(ynum-1)+xnum;
    tt= unique(tt);
    if length(tt)==POINTS
        break;
    end
end

color_temp=[1 0 0];%assign the color

%%chessboard points
x1=X(tt);
y1=Y(tt);

% figure
% plot(Y,X,'r.')
% hold on
% for ii=1:POINTS
%     %      tt=xynum(ii);
%     plot(y1(ii),x1(ii),'r*');
%     text(y1(ii),x1(ii),num2str(ii),'FontSize',15,'color',color_temp);    
% end


%%distortion image points
x1d=p2(cb2(tt),2)';
y1d=p2(cb2(tt),1)';

% %%display the selected points
% figure; imshow(uint8(I2)); hold on;
% for ii=1:POINTS
% %     tt=xynum(ii);
%     plot(y1d(ii),x1d(ii),'r*');
%     text(y1d(ii),x1d(ii),num2str(ii),'FontSize',15,'color',color_temp);
% end





