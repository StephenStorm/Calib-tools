function pred = predictCorners2(chessboard,direction,corners)
    pred_factor = 0.65;
    [row,col] = size(chessboard);
    switch direction 
        case 1 %right expension
            %后列拓展
            pred = zeros(row,2);
            for i=1:row
                p = polyfit(corners(chessboard(i,:),1),corners(chessboard(i,:),2),2);
                pred(i,1) = corners(chessboard(i,end),1)+pred_factor * (corners(chessboard(i,end),1) - corners(chessboard(i,end-1),1));
                pred(i,2) = polyval(p, pred(i,1));
            end
        case 3
           %前列拓展
            pred = zeros(row,2);
            for i=1:row
                p = polyfit(corners(chessboard(i,:),1),corners(chessboard(i,:),2),2);
                pred(i,1) = corners(chessboard(i,1),1)-( pred_factor * (corners(chessboard(i,2),1) - corners(chessboard(i,1),1)) ); 
                pred(i,2) = polyval(p, pred(i,1));
            end
        case 2
            pred = zeros(2,col);
            %后行拓展
            for i=1:col
                p = polyfit(corners(chessboard(:,i),1),corners(chessboard(:,i),2),2);
                pred(1,i) = corners(chessboard(end,i),1)+pred_factor * (corners(chessboard(end,i),1) - corners(chessboard(end-1,i),1));
                pred(2,i) = polyval(p, pred(1,i));
            end
            pred =pred';
        case 4
            %前行拓展
            pred  = zeros(2,col);
            for i=1:col
                p = polyfit(corners(chessboard(:,i),1),corners(chessboard(:,i),2),2);
                pred(1,i) = corners(chessboard(1,i),1)+pred_factor * (corners(chessboard(1,i),1) - corners(chessboard(2,i),1));
                pred(2,i) = polyval(p, pred(1,i));
            end
            pred = pred';
    end
end