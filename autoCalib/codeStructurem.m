I = imread("test.bmp");
corners = findCorners(img,tau,refine_corners)
    template = createCorrelationPatch(angle_1,angle_2,radius)
    %创建2种不同类型，3种不同尺寸（2,4,8）共六种卷积核
    %通过六种卷积核的卷积运算及公式（1）求  c likelihood
    maxima = nonMaximumSuppression(img,n,tau,margin)
    %利用非极大值抑制，n是检测区域边长，最大值区域为2×n，tau为阈值
    %返回大于tau的角点候选点坐标,是n×2 坐标矩阵，注意是[col,row]
    corners = refineCorners(img_du,img_dv,img_angle,img_weight,corners,r)
    %
    %
        [v1,v2] = edgeOrientations(img_angle,img_weight)
        %输入是以  角点为中心，(2r+1)*(2r+1)区域内的梯度方向和2范数
        %返回区域内两个最大的梯度方向alpha1,alpha2 
        %v1 = [cos(alpha1),sin(alpha1)]  v2 = [cos(alpha2),sin(alpha2)]
        %%用32bin直方图统计各个角度梯度幅值
            [modes,hist_smoothed] = findModesMeanShift(hist,sigma)
            %在[-2sigma,2sigma]连续区域内做高斯平滑
            %modes 降序排序后的峰值[index in hist_smoothed],his_smoothed 平滑处理后的直方图值
            
            %验证两角度必须有一定的差值，  
       利用等式5重新计算边的方向
       利用等式（2），（3）重新计算角点坐标至亚像素级别
    corners = scoreCorners(img,img_angle,img_weight,corners,radius)
    %对角点进行 打分
    %取出2*radius(j) +1 的区域 相应值代入如下函数   根据邻域计算得分
        score = cornerCorrelationScore(img,img_weight,v1,v2)
            template = createCorrelationPatch(angle_1,angle_2,radius)
            由template利用公式（1） 获得score_intensity
            score = score_gradient*score_intensity
            
            
                                                                      
        
        
        
        
 chessboards = chessboardsFromCorners(corners)
     chessboard = initChessboard(corners,idx)
        [neighbor_idx,min_dist] = directionalNeighbor(idx,v,chessboard,corners)
     E = chessboardEnergy(chessboard,corners)          
     chessboard = growChessboard(chessboard,corners,border_type)
     %返回拓展一行或一列后的棋盘
         pred = predictCorners(p1,p2,p3)
         %根据已知的连续三点预测角点的位置
          idx = assignClosestCorners(cand,pred)
          %cand为还未使用的候选角点的坐标，pred = 上一函数预测的角点
          %返回值为相应预测点在cand中的索引，即根据预测角点位置选择出最近的角点





%工作量：
normpdf(x,mu,sigma);
refine :  calculate eigenvalues  eigenvector  rank of the matrix(matrix has inverse)
            and solving equtions

