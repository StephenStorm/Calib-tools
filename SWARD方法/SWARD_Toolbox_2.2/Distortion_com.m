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

NoGridRand=POINTS;

%%the distortion of center
centerX=DoC(1);
centerY=DoC(2); 

%%%%%Allrd
x1d=x1d-centerX;
y1d=y1d-centerY;

%compute the  first two rows of H using SVD
A=zeros(NoGridRand,6);      %%%%%%%%%%%%%%%

for mm=1:NoGridRand
    
    A(mm,1)=-x1(mm)*y1d(mm);
    A(mm,2)=-y1(mm)*y1d(mm);
    A(mm,3)=-1*y1d(mm);
    
    A(mm,4)=x1(mm)*x1d(mm);
    A(mm,5)=y1(mm)*x1d(mm);
    A(mm,6)=1*x1d(mm);
end

[U S V]=svd(A);

h1h2= V(:,end)'; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H12=[h1h2(1:3);h1h2(4:6)];%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%H=H12/H12(5)
H=H12
%sssss

AR=sqrt((x1d).^2+(y1d).^2);

%  figure
%  plot(AR,Allrr,'.')

rfy=AR;%%%./Allrr;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rfy1=sort(rfy);
rfy2=rfy1/rfy1(length(rfy1));

%%

h1=H(1,:);
h2=H(2,:);
Hq=zeros(2*NoGridRand,NoGridRand+3);
for m=1:NoGridRand
    Hq(2*m-1,end-2:end) =  -x1d(m)*[x1(m),y1(m),1];
    Hq(2*m-1,m) =h1*[x1(m),y1(m),1]';
    
    Hq(2*m,end-2:end)    =  -y1d(m)*[x1(m),y1(m),1];
    Hq(2*m,m) =h2*[x1(m),y1(m),1]';
end
Hq1=Hq'*Hq;


%sort
[B IX]=sort(AR,'ascend');

%inequality constraints
A1=zeros(NoGridRand-1, NoGridRand+3);

st=1;
for ms=1:NoGridRand-1
    A1(ms,IX(st))=-1;
    A1(ms,IX(st+1))=1;
    st=st+1;
end

b=zeros(1,NoGridRand-1);

Aext1=zeros(1, NoGridRand+3);
Aext1(IX(NoGridRand))=-1;

A1=[A1;Aext1];

bext1=1; %%%%%%%%%%%%%
b=[b,bext1];%%%%%%%%%%%%%
% equality constraint
Aeq=zeros(1,NoGridRand+3);
Aeq(IX(1))=1;
beq=1;

%initial value
x0 = 0.3*ones(1,NoGridRand+3);%%%%%%%%%%%%%
%function parameter Settings
%options = optimset( 'Algorithm','interior-point','GradConstr','on','MaxFunEvals',10000);
% options = optimset( 'Algorithm','interior-point','GradConstr','on','MaxFunEvals',10000,'Display','iter');

t = cputime; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [x,fmin] = fmincon(final_func,x0,A1,b,Aeq,beq,[],[],[],options);
% [x,fmin] = quadprog(Hq1,[],A1,b,Aeq,beq,[],[],x0,options);
% [x,fmin] = quadprog(Hq1,[],A1,b,Aeq,beq,[],[],x0,options)
[x,fmin] = quadprog(Hq1,[],A1,b,Aeq,beq,[],[],x0);

e = cputime-t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rf1=x(1:NoGridRand);
% rh1=x(NoGridRand+1:NoGridRand+3);

rf1=x(1:NoGridRand);
rh1=x(end-2:end);
rh2=rh1/rh1(3);
rh2=rh2'
%H
H_plane=[H;rh2]

% break
% P(:,[1 2 4])
% % P(:,[1 2 4])./(H_plane*inv([1 0 centerX;0 1 centerY; 0 0 1]))%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  P(:,[1 2 4])./(H_plane*([1 0 centerX;0 1 centerY; 0 0 1]))%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % P(:,[1 2 4])./H_plane
%  P(:,[1 2 4])./(([1 0 centerX;0 1 centerY; 0 0 1])*H_plane)   %%%%%%%%%%%%%%%%%%%good
%   P(:,[1 2 4])./(([1 0 centerX;0 1 centerY; 0 0 1])*[-1 0 0; 0 -1 0; 0 0 1]*H_plane)  %%%%%%%%%%%%%%%%%%%good

%  (P(:,[1 2 4]))./(inv([1 0 centerX;0 1 centerY; 0 0 1])*H_plane)
% inv(P(:,[1 2 4]))./(H_plane*inv([1 0 centerX;0 1 centerY; 0 0 1]))
% inv(P(:,[1 2 4]))./(H_plane*([1 0 centerX;0 1 centerY; 0 0 1]))

%%the curve of distortion
r=AR.^2;

%Our method
t=polyfit(r,rf1',1);

%distortion correction
rlamda= t(1)/t(2)

% %plot curve
% rrr=0:1000;
% rrr2=rrr.^2;
% figure
% plot(rrr,rrr./(1+rlamda*rrr2),'b')
% legend('Distortion curve');


