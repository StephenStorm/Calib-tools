% Copyright 2012. All rights reserved.
% Author: Andreas Geiger
%         Institute of Measurement and Control Systems (MRT)
%         Karlsruhe Institute of Technology (KIT), Germany

% This is free software; you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation; either version 3 of the License, or any later version.

% This software is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
% PARTICULAR PURPOSE. See the GNU General Public License for more details.

% You should have received a copy of the GNU General Public License along with
% this software; if not, write to the Free Software Foundation, Inc., 51 Franklin
% Street, Fifth Floor, Boston, MA 02110-1301, USA 

function chessboard = growChessboard(chessboard,corners,border_type)
% return immediately, if there do not exist any chessboards
if isempty(chessboard)
  return;
end

% extract feature locations
p = corners.p;

% list of unused feature elements
unused       = 1:size(corners.p,1);
used         = chessboard(chessboard~=0);
unused(used) = [];

% candidates from unused corners
cand = p(unused,:);

% switch border type 1..4
switch border_type
  
  case 1
    pred = predictCorners(p(chessboard(:,end-2),:),p(chessboard(:,end-1),:),p(chessboard(:,end),:));
%ste:  棋盘后三列的点
    idx = assignClosestCorners(cand,pred);
    if idx~=0
      chessboard = [chessboard unused(idx)'];
    end
    
  case 2
        pred = predictCorners(p(chessboard(end-2,:),:),p(chessboard(end-1,:),:),p(chessboard(end,:),:));
        %ste: 棋盘后三行的点
       idx = assignClosestCorners(cand,pred);
        if idx~=0
          chessboard = [chessboard; unused(idx)];
        end

  case 3
    pred = predictCorners(p(chessboard(:,3),:),p(chessboard(:,2),:),p(chessboard(:,1),:));
    idx = assignClosestCorners(cand,pred);
    %ste：棋盘前三列的点
    if idx~=0
      chessboard = [unused(idx)' chessboard];
    end

  case 4
    pred = predictCorners(p(chessboard(3,:),:),p(chessboard(2,:),:),p(chessboard(1,:),:));
    idx = assignClosestCorners(cand,pred);
    if idx~=0
      chessboard = [unused(idx); chessboard];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% linear prediction (old)
% function pred = predictCorners(p1,p2,p3)
% pred = 2*p3-p2;

% replica prediction (new)
function pred = predictCorners(p1,p2,p3)

% compute vectors
v1 = p2-p1;
v2 = p3-p2;

% predict angles
a1 = atan2(v1(:,2),v1(:,1));
a2 = atan2(v2(:,2),v2(:,1));
a3 = 2*a2-a1;
% a3 = a2;

% predict scales
s1 = sqrt(v1(:,1).^2+v1(:,2).^2);
s2 = sqrt(v2(:,1).^2+v2(:,2).^2);
s3 = 2*s2-s1;

% predict p3 (the factor 0.75 ensures that under extreme
% distortions (omnicam) the closer prediction is selected)
% predict factor pred_factor (default = 0.75)
pred_factor = 0.70;
pred = p3 + pred_factor*s3*ones(1,2) .* [cos(a3) sin(a3)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function idx = assignClosestCorners(cand,pred)

% return error if not enough candidates are available
if size(cand,1)<size(pred,1)
  idx = 0;
  return;
end

% build distance matrix
D = zeros(size(cand,1),size(pred,1)); %每一列表示候选角点【row】到预测角点【col】的距离 
for i=1:size(pred,1)
  delta  = cand-ones(size(cand,1),1)*pred(i,:);
  D(:,i) = sqrt(delta(:,1).^2+delta(:,2).^2); %候选角点到预测角点的距离
end

% search greedily for closest corners
for i=1:size(pred,1)
  [row,col] = find(D==min(D(:)),1,'first');
  idx(col)  = row;%row表示索引为col的预测角点对应的未使用角点在cand中的索引
  D(row,:)  = inf;
  D(:,col)  = inf;
end
