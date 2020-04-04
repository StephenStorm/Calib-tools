function plotCorners(chessboards,corners)
%PLOTCORNERS （调试用）绘制所有可能的角点和棋盘格生成角点。
%   确定某些角点是否被检测到;确定某些角点的生成有哪些实际错误。

scatter(corners.p(:,1),corners.p(:,2),[],'r','filled','LineWidth',0.1);

for i=1:length(chessboards)
    cb = chessboards{i};
    for j=1:size(cb,1)
        p = corners.p(cb(j,:),:) + 1;
        scatter(p(:,1),p(:,2),18,'b','filled','LineWidth',0.1);
%         disp(p);
    end
end