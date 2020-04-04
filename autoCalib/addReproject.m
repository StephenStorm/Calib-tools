
clear variables; dbstop error; close all;
disp('================================');

addpath('matching');
addpath('ocam_calib');
tau = 0.01;


% I = imread('img/front_1.jpg');
% [fM,lM] = reProject;
% corners = findCorners(I,tau,1);
% p = corners.p;
% p(:, [1 2]) = p(:,[2 1]);
% tmp = fM(:,:,1);
% tmp = tmp';
% res = assignClosestCorners(p+1,tmp);
% figure; imshow(I);hold on;
% scatter(p(:,2),p(:,1),'g','filled');%检测出的角点
% scatter(res(2,:),res(1,:),'r','filled');%就近取得角点



[fM,lM] = reProject;
para_front = {'./img/front_1.jpg','./img/rear_1.jpg'};
para_left = {'./img/left_1.jpg','./img/right_1.jpg'};

para_front_test = {'./img/front_test.bmp','./img/rear_test.bmp'};
para_left_test = {'./img/left_test.bmp','./img/right_test.bmp'};

%{
%两张同位置的照片不能正确检测到棋盘格角点
para_rear2 = {'./img/rear_1.jpg','./img/rear_test.bmp'};

    tmp = fM(:,:,2);
    tmp = tmp';
     I = imread(para_rear2{2});
     figure;    
    imshow(I);
    hold on;
    scatter(tmp(:,2),tmp(:,1),'r','filled');
    

 I = imread(para_rear2{1});
    corners = findCorners(I,tau,1);
    p = corners.p;
    p(:, [1 2]) = p(:,[2 1]);
    res = assignClosestCorners(p+1,tmp);
    figure;    
    imshow(I);
    hold on;
    scatter(p(:,2),p(:,1),'g','filled');%检测出的角点
    scatter(res(2,:),res(1,:),'r','filled');%就近取得角点
   %} 
   
%{
for i=2:2
    I = imread(para_front_test{i});
    
    
    corners = findCorners(I,tau,1);
    p = corners.p;
%     p(:, [1 2]) = p(:,[2 1]);
    tmp = fM(:,:,i);%图像坐标
    tmp = tmp';
    tmp(:,[1 2]) = tmp(:,[2 1]);
    res = assignClosestCorners2(p+1,tmp);
    figure;    
    imshow(I);
    hold on;
    scatter(p(:,1),p(:,2),'g','filled','linewidth',0.1);%检测出的角点
    scatter(res(1,:),res(2,:),'r','filled','linewidth',0.1);%就近取得角点
    scatter(tmp(:,1),tmp(:,2),'c','linewidth',0.1);%预测角点位置

end
%}


for i=1:1
     I = imread(para_left_test{i});
    corners = findCorners(I,tau,1);
    p = corners.p;
%     p(:, [1 2]) = p(:,[2 1]);
    tmp = lM(:,:,i);
    tmp = tmp';
    tmp(:,[1 2]) = tmp(:,[2 1]);
    res = assignClosestCorners2(p+1,tmp);
    figure;    
    imshow(I);
    hold on;
    scatter(p(:,1),p(:,2),'g','filled');%检测出的角点
    scatter(res(1,:),res(2,:),'r','filled','linewidth',0.1);%就近取得角点
     scatter(tmp(:,1),tmp(:,2),'c','linewidth',0.1);%预测角点位置
end
