function gen_car2top_lut2(cam2car, lutFile,ocam_model, car2top,border,is_cut)
    src_size = [720,1280];
    src_size_col = [1280, 720];
    %dst_size = [320 768];
    dst_size = [512 512];
    %dst_size_col = [768 320];
    dst_size_col = [512 512];
    [mapx mapy] = meshgrid(0:src_size(1)-1,0:src_size(2)-1);
    mapxy = [mapx(:),mapy(:)]';
    
    points3Dt = cam2world(mapxy, ocam_model);
    points3D = [points3Dt;ones(1,size(points3Dt,2))];
    points3D_world = cam2car * points3D;
    points3D_world = points3D_world(1:3,:);
    center3D_worldt = cam2car * [0 0 0 1]';
    center3D_world = center3D_worldt(1:3,:);
    center3D_worlds = repmat(center3D_world,1,size(points3D_world,2));
    vectors = center3D_worlds -points3D_world;
    temp1 = -center3D_worlds(3) ./ vectors(3,:);
    vectors(1,:) = vectors(1,:) .* temp1;
    vectors(2,:) = vectors(2,:) .* temp1;
    vectors(3,:) = vectors(3,:) .* temp1;
    rest = vectors + center3D_worlds;
    resx = reshape(rest(1,:),src_size_col);
    resy = reshape(rest(2,:),src_size_col);
    if(is_cut == 1)
        resx = imcrop(resx, [91 161 540 960]);
        resy = imcrop(resy, [91 161 540 960]);
    end
    
    ttx = imresize(resx,dst_size_col,'bicubic');
    tty = imresize(resy,dst_size_col,'bicubic');
    res = ones(3,dst_size(1)*dst_size(2));
    res(1,:) = ttx(:)';
    res(2,:) = tty(:)';
    restt = car2top * res;
    final = round(restt(1:2,:));
    %处理越界值,>511 ->300   <0 -> -1
    %{
    index = final >= border;
    final(index) = border+100;
    index = final < 0;
    final(index) = -1;
    %}
    lut_file = fopen(lutFile,'wb');
    fwrite(lut_file,final,'int32');
    end