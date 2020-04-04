function res = assignClosestCorners2(cand,pred)
%res  2*n

res = pred';
% return error if not enough candidates are available
if size(cand,1)<size(pred,1)
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
  if D(row,col) < 30
      res(:,col) = cand(row,:);
  end
  D(row,:)  = inf;
  D(:,col)  = inf;
end