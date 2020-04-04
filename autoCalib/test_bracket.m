I = imread('data/test02.jpg');
corners = findCorners(I,0.01,1);
p = corners.p;

figure;
imshow(uint8(I)); hold on;
scatter(p(:,1),p(:,2),'r','fillled');


% x = 1:10;
% y = 10:10:100;
% scatter(x,y,'filled');