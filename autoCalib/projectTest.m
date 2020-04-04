[fM,lM] = reProject;
para_front = {'./img/front_1.jpg','./img/rear_1.jpg'};
para_left = {'./img/left_1.jpg','./img/right_1.jpg'};
for i=1:2
    figure;
    I = imread(para_front{i});
    imshow(I);
    hold on;
    scatter(fM(2,:,i),fM(1,:,i),'r','filled');
end

for i=1:2
    figure;
    I = imread(para_left{i});
    imshow(I);
    hold on;
    scatter(lM(2,:,i),lM(1,:,i),'r','filled');
end
