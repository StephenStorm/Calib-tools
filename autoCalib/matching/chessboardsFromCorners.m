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

function chessboards = chessboardsFromCorners(corners)

fprintf('Structure recovery:\n');

% intialize chessboards
chessboards = [];

% for all seed corners do
for i=1:size(corners.p,1)
  
  % output
%   if mod(i-1,100)==0
%     fprintf('%d/%d\n',i,size(corners.p,1));
%   end
  
  % init 3x3 chessboard from seed i
  chessboard = initChessboard(corners,i);
  
if size(chessboard,1)==0
    
    continue;
end

  % try growing chessboard
  while 1
    
    % compute current energy
    energy = chessboardEnergy(chessboard,corners);
    
    % compute proposals and energies
    for j=1:4
      proposal{j} = growChessboard(chessboard,corners,j);
      p_energy(j) = chessboardEnergy(proposal{j},corners);
      
    end
    
    % find best proposal
    [min_val,min_idx] = min(p_energy);
    
    
    
    % accept best proposal, if energy is reduced
%     if p_energy(min_idx)<energy
    if p_energy(min_idx) < energy
      chessboard = proposal{min_idx};
      
      if 0
        figure, hold on, axis equal;
        chessboards{1} = chessboard;
        plotChessboards(chessboards,corners);
        keyboard;
      end
      
    % otherwise exit loop
    else
      break;
    end
  end
  % if chessboard has low energy (corresponding to high quality)
 % if chessboardEnergy(chessboard,corners)<-10
   if chessboardEnergy(chessboard,corners)<-10
  
    % check if new chessboard proposal overlaps with existing chessboards
    overlap = zeros(length(chessboards),2);
    %n×2 矩阵，第一列表示row棋盘是否有重叠，第二列记录row棋盘的energe
    for j=1:length(chessboards) %棋盘个数
      for k=1:length(chessboards{j}(:))  %当前棋盘格数
        if any(chessboards{j}(k)==chessboard(:))
          overlap(j,1) = 1;
          overlap(j,2) = chessboardEnergy(chessboards{j},corners);
          break;
        end
      end
    end

    % add chessboard (and replace overlapping if neccessary)
    if ~any(overlap(:,1))
      chessboards{end+1} = chessboard;
    else
      idx = find(overlap(:,1)==1);
      if ~any(overlap(idx,2)<=chessboardEnergy(chessboard,corners))
        chessboards(idx) = [];
        chessboards{end+1} = chessboard;
      end
    end
  end
end

fprintf('\n');
