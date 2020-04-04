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

function chessboard = initChessboard(corners,idx)
%idx 是角点的线性索引

% return if not enough corners
if size(corners.p,1)<9
  chessboard = [];
  return;
end

% init chessboard hypothesis
chessboard = zeros(3,3);

% extract feature index and orientation (central element)
v1 = corners.v1(idx,:);
v2 = corners.v2(idx,:);
chessboard(2,2) = idx;

% find left/right/top/bottom neighbors
[chessboard(2,3),dist1(1)] = directionalNeighbor(idx,+v1,chessboard,corners);
[chessboard(2,1),dist1(2)] = directionalNeighbor(idx,-v1,chessboard,corners);
[chessboard(3,2),dist2(1)] = directionalNeighbor(idx,+v2,chessboard,corners);
[chessboard(1,2),dist2(2)] = directionalNeighbor(idx,-v2,chessboard,corners);

% find top-left/top-right/bottom-left/bottom-right neighbors
[chessboard(1,1),dist2(3)] = directionalNeighbor(chessboard(2,1),-v2,chessboard,corners);
[chessboard(3,1),dist2(4)] = directionalNeighbor(chessboard(2,1),+v2,chessboard,corners);
[chessboard(1,3),dist2(5)] = directionalNeighbor(chessboard(2,3),-v2,chessboard,corners);
[chessboard(3,3),dist2(6)] = directionalNeighbor(chessboard(2,3),+v2,chessboard,corners);

% test std to determine the max_std

% if ~any(isinf(dist1)) && ~any(isinf(dist2))
%  disp(idx);
%  disp(std(dist1)/mean(dist1));
%  disp(std(dist2)/mean(dist2));
% end

% set max std/mean val 使得检测的棋盘格更大一些
max_std_val =50;
%ste: default 0.3

% initialization must be homogenously distributed
if any(isinf(dist1)) || any(isinf(dist2)) || ...
   std(dist1)/mean(dist1)>max_std_val || std(dist2)/mean(dist2)>max_std_val
  chessboard = [];
  return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [neighbor_idx,min_dist] = directionalNeighbor(idx,v,chessboard,corners)

% list of neighboring elements, which are currently not in use
unused       = 1:size(corners.p,1);
used         = chessboard(chessboard~=0);
unused(used) = [];

% direction and distance to unused corners
dir  = corners.p(unused,:) - ones(length(unused),1)*corners.p(idx,:); %n*2
dist = (dir(:,1)*v(1)+dir(:,2)*v(2));
%在v方向上的投影长度？？
% distances
dist_edge = dir-dist*v;
dist_edge = sqrt(dist_edge(:,1).^2+dist_edge(:,2).^2);   %没用到的角点到V方向的垂直距离
dist_point = dist;  %在v方向上的投影长度
dist_point(dist_point<0) = inf;  %只保留正向的投影长度，即与v方向一致

% find best neighbor
[min_dist,min_idx] = min(dist_point+5*dist_edge);
neighbor_idx = unused(min_idx);
