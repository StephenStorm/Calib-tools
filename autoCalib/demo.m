clear variables; dbstop error; close all;
disp('================================');

addpath('matching');
tau = 0.08;
%default 0.01
%pred_factor
%

% I = imread('front0.jpg');

I = imread('img/20190818/left_0.jpg');
figure; imshow(uint8(I));
impixelinfo;
hold on;
corners = findCorners(I,tau,1);
scatter(corners.p(:,1),corners.p(:,2),'r','filled');

chessboards = chessboardsFromCorners(corners);
% chessboardEnergy(chessboards{1},corners)
[m,n] = size(chessboards{1});
plotChessboards(chessboards,corners);
plotCorners(chessboards,corners);