clear;
clc;


%% top ->  four  single
bin_file_front = './output/car2top_lut/front_car2top_lut_20_512.bin';
bin_file_right = 	'./output/car2top_lut/right_car2top_lut_20_512.bin';
bin_file_rear  = './output/car2top_lut/rear_car2top_lut_20_512.bin';
bin_file_left   = './output/car2top_lut/left_car2top_lut_20_512.bin';

generate_bin_file =0;

physical_size = [10000 10000];
pixel_size = [256 256];
%是否进行[540  960] 的裁剪  1表示裁剪,  非1  表示不裁剪
is_cut = 0;



%%file name define
imgFile = './output/20191219SurroundViewLixiang.jpg';
lutFile = './output/20191219Lixiang_256_10m.bin';
matFile = './output/20191219Lixiang.mat';

side_ver = 35;%135;
side_squ_num = 9;


car_length = 5020;
car_width = 1960;
back_axis_to_rear_cam = 1100;
back_axis_to_front_cam = car_length-back_axis_to_rear_cam;


%% Load data (Da tong)
% calib_data_front = load('datong_front_1.mat');
% calib_data_right = load('datong_right_1.mat');
% calib_data_back = load('datong_back_1.mat');
% calib_data_left = load('datong_left_1.mat');
% 
% calib_data_front = calib_data_front.calib_data_front;
% calib_data_right = calib_data_right.calib_data_right;
% calib_data_back = calib_data_back.calib_data_back;
% calib_data_left = calib_data_left.calib_data_left;
% 
% % Extrinsic  parameters
% rrt_front = calib_data_front.RRfin;
% rrt_right = calib_data_right.RRfin;
% rrt_back = calib_data_back.RRfin;
% rrt_left = calib_data_left.RRfin;
% 
% % Intrinsic parameters
% ocam_model_front = calib_data_front.ocam_model;
% ocam_model_right = calib_data_right.ocam_model;
% ocam_model_back = calib_data_back.ocam_model;
% ocam_model_left = calib_data_left.ocam_model;
% 
% ocam_model_front.pol = findinvpoly(ocam_model_front.ss,sqrt((ocam_model_front.width/2)^2+(ocam_model_front.height/2)^2));
% ocam_model_right.pol = findinvpoly(ocam_model_right.ss,sqrt((ocam_model_right.width/2)^2+(ocam_model_right.height/2)^2));
% ocam_model_back.pol = findinvpoly(ocam_model_back.ss,sqrt((ocam_model_back.width/2)^2+(ocam_model_back.height/2)^2));
% ocam_model_left.pol = findinvpoly(ocam_model_left.ss,sqrt((ocam_model_left.width/2)^2+(ocam_model_left.height/2)^2));
% 
% % Load image
% input_front = double(imread('datong_front_1.bmp'))/255;
% input_right = double(imread('datong_right_1.bmp'))/255;
% input_back = double(imread('datong_back_1.bmp'))/255;
% input_left = double(imread('datong_left_1.bmp'))/255;
% % show_four_images(input_front,input_right,input_back,input_left);
% 
% % Top view coordinate
% % top_size_m_pixel = 300;
% % top_size_n_pixel = 125;
% top_size_m_pixel = 416;
% top_size_n_pixel = 416;
% top_size_pixel = [top_size_m_pixel;top_size_n_pixel];
% % top_mm_per_pixel = 40;
% top_mm_per_pixel = 10000/416;
% top_size_mm = top_size_pixel*top_mm_per_pixel;
% 
% % Car coordinate
% % Place the car in the middle of top view
% top_to_car_offset_mm = top_size_mm/2;
% top_to_car_rotate = [-1,0;0,-1];
% 
% % Front coordinate
% car_to_front_offset_mm = [3855;750];
% car_to_front_rotate = [-1,0;0,-1];
% 
% % Right coordinate
% % car_to_right_offset_mm = [1295;-2270+3*300+62.5*40];
% car_to_right_offset_mm = [1295;-2270];
% car_to_right_rotate = [0,1;-1,0];
% 
% % Back coordinate
% car_to_back_offset_mm = [-3885;-750];
% car_to_back_rotate = [1,0;0,1];
% 
% % Left coordinate
% car_to_left_offset_mm = [-205;2270];
% car_to_left_rotate = [0,-1;1,0];

%% Load data (Gu an)
% calib_data_front = load('20190312_guan_front_0.mat');
% calib_data_right = load('20190312_guan_right_0.mat');
% calib_data_back = load('20190312_guan_back_0.mat');
% calib_data_left = load('20190312_guan_left_0.mat');
% 
% calib_data_front = calib_data_front.calib_data_front;
% calib_data_right = calib_data_right.calib_data_right;
% calib_data_back = calib_data_back.calib_data_back;
% calib_data_left = calib_data_left.calib_data_left;
% 
% % Extrinsic  parameters
% rrt_front = calib_data_front.RRfin;
% rrt_right = calib_data_right.RRfin;
% rrt_back = calib_data_back.RRfin;
% rrt_left = calib_data_left.RRfin;
% 
% % Intrinsic parameters
% ocam_model_front = calib_data_front.ocam_model;
% ocam_model_right = calib_data_right.ocam_model;
% ocam_model_back = calib_data_back.ocam_model;
% ocam_model_left = calib_data_left.ocam_model;
% 
% ocam_model_front.pol = findinvpoly(ocam_model_front.ss,sqrt((ocam_model_front.width/2)^2+(ocam_model_front.height/2)^2));
% ocam_model_right.pol = findinvpoly(ocam_model_right.ss,sqrt((ocam_model_right.width/2)^2+(ocam_model_right.height/2)^2));
% ocam_model_back.pol = findinvpoly(ocam_model_back.ss,sqrt((ocam_model_back.width/2)^2+(ocam_model_back.height/2)^2));
% ocam_model_left.pol = findinvpoly(ocam_model_left.ss,sqrt((ocam_model_left.width/2)^2+(ocam_model_left.height/2)^2));
% 
% % Load image
% input_front = double(imread('20190312_guan_front_0.bmp'))/255;
% input_right = double(imread('20190312_guan_right_0.bmp'))/255;
% input_back = double(imread('20190312_guan_back_0.bmp'))/255;
% input_left = double(imread('20190312_guan_left_0.bmp'))/255;
% % show_four_images(input_front,input_right,input_back,input_left);
% 
% % Top view coordinate
% % top_size_m_pixel = 300;
% % top_size_n_pixel = 125;
% top_size_m_pixel = 416;
% top_size_n_pixel = 416;
% top_size_pixel = [top_size_m_pixel;top_size_n_pixel];
% top_mm_per_pixel = 10000/416;
% top_size_mm = top_size_pixel*top_mm_per_pixel;
% 
% % Car coordinate
% % Place the car in the middle of top view
% top_to_car_offset_mm = top_size_mm/2+[4718.5/2-1004.5;0];
% top_to_car_rotate = [-1,0;0,-1];
% 
% % Front coordinate
% car_to_front_offset_mm = [460.5*8.5+1355;460.5*5.5];
% car_to_front_rotate = [-1,0;0,-1];
% 
% % Right coordinate
% car_to_right_offset_mm = [460.5*8.5+1355;-460.5*5.5];
% car_to_right_rotate = [0,1;-1,0];
% 
% % Back coordinate
% car_to_back_offset_mm = [-460.5*8.5+1355;-460.5*6.5];
% car_to_back_rotate = [1,0;0,1];
% 
% % Left coordinate
% car_to_left_offset_mm = [-460.5*8.5+1355;460.5*5.5];
% car_to_left_rotate = [0,-1;1,0];

%% Load data (20190414_guan_datong)
calib_data_front = load('front_Omni_Calib_Results.mat');
calib_data_right = load('right_Omni_Calib_Results.mat');
calib_data_back = load('rear_Omni_Calib_Results.mat');
calib_data_left = load('left_Omni_Calib_Results.mat');

% calib_data_front = calib_data_front.calib_data_front;
% calib_data_right = calib_data_right.calib_data_right;
% calib_data_back = calib_data_back.calib_data_back;
% calib_data_left = calib_data_left.calib_data_left;
% 
% % Extrinsic  parameters
% rrt_front = calib_data_front.RRfin;
% rrt_right = calib_data_right.RRfin;
% rrt_back = calib_data_back.RRfin;
% rrt_left = calib_data_left.RRfin;

calib_data_front = calib_data_front.calib_data;
calib_data_right = calib_data_right.calib_data;
calib_data_back = calib_data_back.calib_data;
calib_data_left = calib_data_left.calib_data;

% Extrinsic  parameters
rrt_front = calib_data_front.RRfin;
rrt_right = calib_data_right.RRfin;
rrt_back = calib_data_back.RRfin;
rrt_left = calib_data_left.RRfin;

% Intrinsic parameters
ocam_model_front = calib_data_front.ocam_model;
ocam_model_right = calib_data_right.ocam_model;
ocam_model_back = calib_data_back.ocam_model;
ocam_model_left = calib_data_left.ocam_model;

ocam_model_front.pol = findinvpoly(ocam_model_front.ss,sqrt((ocam_model_front.width/2)^2+(ocam_model_front.height/2)^2));
ocam_model_right.pol = findinvpoly(ocam_model_right.ss,sqrt((ocam_model_right.width/2)^2+(ocam_model_right.height/2)^2));
ocam_model_back.pol = findinvpoly(ocam_model_back.ss,sqrt((ocam_model_back.width/2)^2+(ocam_model_back.height/2)^2));
ocam_model_left.pol = findinvpoly(ocam_model_left.ss,sqrt((ocam_model_left.width/2)^2+(ocam_model_left.height/2)^2));

% Load image
input_front = double(imread('front0.jpg'))/255;
input_right = double(imread('right0.jpg'))/255;
input_back = double(imread('rear0.jpg'))/255;
input_left = double(imread('left0.jpg'))/255;
% input_front = double(imread('byd_front.png'))/255;
% input_right = double(imread('byd_right.png'))/255;
% input_back = double(imread('byd_back.png'))/255;
% input_left = double(imread('byd_left.png'))/255;
% input_front = double(imread('20190419_datong/front0.bmp'))/255;
% input_right = double(imread('20190419_datong/left0.bmp'))/255;
% input_back = double(imread('20190419_datong/rear0.bmp'))/255;
% input_left = double(imread('20190419_datong/right0.bmp'))/255;

% show_four_images(input_front,input_right,input_back,input_left);

% Top view coordinate
top_size_m_pixel = pixel_size(1);
top_size_n_pixel = pixel_size(2);
top_size_pixel = [top_size_m_pixel;top_size_n_pixel];
top_mm_per_pixel = physical_size(1) / pixel_size(1); % 1 pixel -> world size (mm)
top_size_mm = top_size_pixel*top_mm_per_pixel;

% Car coordinate

top_to_car_offset_mm = [car_length/2 - back_axis_to_rear_cam;0]+top_size_mm/2;
top_to_car_rotate = [-1,0;0,-1];
% car length = 4718.5
% car back axis to the end of the car = 1004.5

% Place the car in the middle of top view


% Origin in Car coordinate is on the mid of car axle

% set origin of front RRfin to center of back axis

% rrf_front(3,3) = rrf_front(3,3) - (4718.5-1004.5);

% Front coordinate
% car_to_front_offset_mm = [600*9-100;600*4];
% car_to_front_rotate = [-1,0;0,-1];
car_to_front_offset_mm = [side_ver+side_squ_num*600;600*4];
car_to_front_rotate = [-1,0;0,-1];

% Right coordinate
car_to_right_offset_mm = [side_ver+side_squ_num*600;-600*4];
car_to_right_rotate = [0,1;-1,0];

% Back coordinate
car_to_back_offset_mm = [-600*14+side_ver+side_squ_num*600;-600*4];
car_to_back_rotate = [1,0;0,1];

% Left coordinate
%car_to_left_offset_mm = [-600*14+side_ver+side_squ_num*600;600*4];
car_to_left_offset_mm = [-600*12+side_ver+side_squ_num*600;600*4];
car_to_left_rotate = [0,-1;1,0];

% wrong top view coordinate
% top_size_m_pixel = 416;
% top_size_n_pixel = 416;
% top_size_pixel = [top_size_m_pixel;top_size_n_pixel];
% top_mm_per_pixel = 10000/416;
% top_size_mm = top_size_pixel*top_mm_per_pixel;
% 
% % Car coordinate
% % Place the car in the middle of top view
% top_to_car_offset_mm = [4718.5/2-1004.5;0]+top_size_mm/2;
% top_to_car_rotate = [-1,0;0,-1];
% 
% % Front coordinate
% car_to_front_offset_mm = [600*9-100;600*4];
% car_to_front_rotate = [-1.10,0;0,-1];
% 
% % Right coordinate
% car_to_right_offset_mm = [590*9-100;-700*4];
% car_to_right_rotate = [-0.03,1;-1,0];
% 
% % Back coordinate
% car_to_back_offset_mm = [-600*4-100;-600*4];
% car_to_back_rotate = [1.2,0;0,1];
% 
% % Left coordinate
% car_to_left_offset_mm = [-770*4-100;580*4];
% car_to_left_rotate = [0.05,-1;1,0];
%% Top view
[lut_u_front,lut_v_front,lut_valid_front] = generate_lut_v1( ...
    top_size_pixel,top_mm_per_pixel, ...
    top_to_car_offset_mm,top_to_car_rotate, ...
    car_to_front_offset_mm,car_to_front_rotate, ...
    rrt_front,ocam_model_front, ...
    size(input_front));
% lut_valid_front = lut_valid_front*0;
[lut_u_right,lut_v_right,lut_valid_right] = generate_lut_v1( ...
    top_size_pixel,top_mm_per_pixel, ...
    top_to_car_offset_mm,top_to_car_rotate, ...
    car_to_right_offset_mm,car_to_right_rotate, ...
    rrt_right,ocam_model_right, ...
    size(input_right));
[lut_u_back,lut_v_back,lut_valid_back] = generate_lut_v1( ...
    top_size_pixel,top_mm_per_pixel, ...
    top_to_car_offset_mm,top_to_car_rotate, ...
    car_to_back_offset_mm,car_to_back_rotate, ...
    rrt_back,ocam_model_back, ...
    size(input_back));
% lut_valid_back = lut_valid_back*0;
[lut_u_left,lut_v_left,lut_valid_left] = generate_lut_v1( ...
    top_size_pixel,top_mm_per_pixel, ...
    top_to_car_offset_mm,top_to_car_rotate, ...
    car_to_left_offset_mm,car_to_left_rotate, ...
    rrt_left,ocam_model_left, ...
    size(input_left));
% lut_valid_left = lut_valid_left*0;

top_view_front = generate_top_view( ...
    input_front,top_size_pixel, ...
    lut_u_front,lut_v_front,lut_valid_front);
top_view_right = generate_top_view( ...
    input_right,top_size_pixel, ...
    lut_u_right,lut_v_right,lut_valid_right);
top_view_back = generate_top_view( ...
    input_back,top_size_pixel, ...
    lut_u_back,lut_v_back,lut_valid_back);
top_view_left = generate_top_view( ...
    input_left,top_size_pixel, ...
    lut_u_left,lut_v_left,lut_valid_left);
% show_four_images(top_view_front,top_view_right,top_view_back,top_view_left);
surround_view = generate_surround_view( ...
    top_view_front,lut_valid_front, ...
    top_view_right,lut_valid_right, ...
    top_view_back,lut_valid_back, ...
    top_view_left,lut_valid_left);
% figure; imshow(surround_view);

%% Surround view (Develop)

% car_length_mm = 4718.5; % saix maxus
% car_width_mm = 2108; % saix maxus

% car_length_mm = 4890; % highlander
% car_width_mm = 2108; % highlander

car_length_mm = car_length; % highlander
car_width_mm = car_width; % highlander

lf_rel_car_mm = [car_length_mm/2;car_width_mm/2]+[car_length/2 - back_axis_to_rear_cam;0];
fr_rel_car_mm = [car_length_mm/2;-car_width_mm/2]+[car_length/2 - back_axis_to_rear_cam;0];
rb_rel_car_mm = [-car_length_mm/2;-car_width_mm/2]+[car_length/2 - back_axis_to_rear_cam;0];
bl_rel_car_mm = [-car_length_mm/2;car_width_mm/2]+[car_length/2 - back_axis_to_rear_cam;0];

lf_rel_top_mm = top_to_car_rotate^-1*lf_rel_car_mm+top_to_car_offset_mm;
fr_rel_top_mm = top_to_car_rotate^-1*fr_rel_car_mm+top_to_car_offset_mm;
rb_rel_top_mm = top_to_car_rotate^-1*rb_rel_car_mm+top_to_car_offset_mm;
bl_rel_top_mm = top_to_car_rotate^-1*bl_rel_car_mm+top_to_car_offset_mm;

lf_rel_top_pixel = round(lf_rel_top_mm/top_mm_per_pixel);
fr_rel_top_pixel = round(fr_rel_top_mm/top_mm_per_pixel);
rb_rel_top_pixel = round(rb_rel_top_mm/top_mm_per_pixel);
bl_rel_top_pixel = round(bl_rel_top_mm/top_mm_per_pixel);

% front(start)
lut_valid_mask_front = false(top_size_pixel');
% front(left)
bound_rel_top_pixel = lf_rel_top_pixel;
while valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_front(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[-1;0];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[-1;-1];
end
% front(middle)
bound_rel_top_pixel = lf_rel_top_pixel;
while bound_rel_top_pixel(1) ~= fr_rel_top_pixel(1) || ...
        bound_rel_top_pixel(2) ~= fr_rel_top_pixel(2)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_front(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[-1;0];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[0;1];
end
% front(right)
bound_rel_top_pixel = fr_rel_top_pixel;
while true
    if valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
        tmp_rel_top_pixel = bound_rel_top_pixel;
        while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
            lut_valid_mask_front(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
            tmp_rel_top_pixel = tmp_rel_top_pixel+[-1;0];
        end
        bound_rel_top_pixel = bound_rel_top_pixel+[-1;1];
    else
        break;
    end
end
lut_valid_front = lut_valid_front&lut_valid_mask_front;
% front(end)

% right(start)
lut_valid_mask_right = false(top_size_pixel');
% right(front)
bound_rel_top_pixel = fr_rel_top_pixel;
while valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_right(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[0;1];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[-1;1];
end
% right(middle)
bound_rel_top_pixel = fr_rel_top_pixel;
while bound_rel_top_pixel(1) ~= rb_rel_top_pixel(1) || ...
        bound_rel_top_pixel(2) ~= rb_rel_top_pixel(2)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_right(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[0;1];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[1;0];
end
% right(back)
bound_rel_top_pixel = rb_rel_top_pixel;
while true
    if valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
        tmp_rel_top_pixel = bound_rel_top_pixel;
        while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
            lut_valid_mask_right(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
            tmp_rel_top_pixel = tmp_rel_top_pixel+[0;1];
        end
        bound_rel_top_pixel = bound_rel_top_pixel+[1;1];
    else
        break;
    end
end
lut_valid_right = lut_valid_right&lut_valid_mask_right;
% right(end)

% back(start)
lut_valid_mask_back = false(top_size_pixel');
% back(right)
bound_rel_top_pixel = rb_rel_top_pixel;
while valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_back(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[1;0];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[1;1];
end
% back(middle)
bound_rel_top_pixel = rb_rel_top_pixel;
while bound_rel_top_pixel(1) ~= bl_rel_top_pixel(1) || ...
        bound_rel_top_pixel(2) ~= bl_rel_top_pixel(2)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_back(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[1;0];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[0;-1];
end
% back(left)
bound_rel_top_pixel = bl_rel_top_pixel;
while true
    if valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
        tmp_rel_top_pixel = bound_rel_top_pixel;
        while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
            lut_valid_mask_back(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
            tmp_rel_top_pixel = tmp_rel_top_pixel+[1;0];
        end
        bound_rel_top_pixel = bound_rel_top_pixel+[1;-1];
    else
        break;
    end
end
lut_valid_back = lut_valid_back&lut_valid_mask_back;
% back(end)

% left(start)
lut_valid_mask_left = false(top_size_pixel');
% left(back)
bound_rel_top_pixel = bl_rel_top_pixel;
while valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_left(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[0;-1];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[1;-1];
end
% left(middle)
bound_rel_top_pixel = bl_rel_top_pixel;
while bound_rel_top_pixel(1) ~= lf_rel_top_pixel(1) || ...
        bound_rel_top_pixel(2) ~= lf_rel_top_pixel(2)
    tmp_rel_top_pixel = bound_rel_top_pixel;
    while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
        lut_valid_mask_left(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
        tmp_rel_top_pixel = tmp_rel_top_pixel+[0;-1];
    end
    bound_rel_top_pixel = bound_rel_top_pixel+[-1;0];
end
% left(front)
bound_rel_top_pixel = lf_rel_top_pixel;
while true
    if valid_pixel_coordinate(bound_rel_top_pixel,top_size_pixel)
        tmp_rel_top_pixel = bound_rel_top_pixel;
        while valid_pixel_coordinate(tmp_rel_top_pixel,top_size_pixel)
            lut_valid_mask_left(tmp_rel_top_pixel(1),tmp_rel_top_pixel(2)) = true;
            tmp_rel_top_pixel = tmp_rel_top_pixel+[0;-1];
        end
        bound_rel_top_pixel = bound_rel_top_pixel+[-1;-1];
    else
        break;
    end
end
lut_valid_left = lut_valid_left&lut_valid_mask_left;
% left(end)

top_view_front = generate_top_view( ...
    input_front,top_size_pixel, ...
    lut_u_front,lut_v_front,lut_valid_front);
top_view_right = generate_top_view( ...
    input_right,top_size_pixel, ...
    lut_u_right,lut_v_right,lut_valid_right);
top_view_back = generate_top_view( ...
    input_back,top_size_pixel, ...
    lut_u_back,lut_v_back,lut_valid_back);
top_view_left = generate_top_view( ...
    input_left,top_size_pixel, ...
    lut_u_left,lut_v_left,lut_valid_left);
% show_four_images(top_view_front,top_view_right,top_view_back,top_view_left);
surround_view = generate_surround_view( ...
    top_view_front,lut_valid_front, ...
    top_view_right,lut_valid_right, ...
    top_view_back,lut_valid_back, ...
    top_view_left,lut_valid_left);
figure; imshow(surround_view);
impixelinfo;

surround_view_lut.top_size_pixel = top_size_pixel;
surround_view_lut.lut_u_front = lut_u_front;
surround_view_lut.lut_v_front =lut_v_front;
surround_view_lut.lut_valid_front = lut_valid_front;
surround_view_lut.lut_u_right = lut_u_right;
surround_view_lut.lut_v_right =lut_v_right;
surround_view_lut.lut_valid_right = lut_valid_right;
surround_view_lut.lut_u_back = lut_u_back;
surround_view_lut.lut_v_back =lut_v_back;
surround_view_lut.lut_valid_back = lut_valid_back;
surround_view_lut.lut_u_left = lut_u_left;
surround_view_lut.lut_v_left =lut_v_left;
surround_view_lut.lut_valid_left = lut_valid_left;
% save('20190226_datong_surround_view_lut.mat','surround_view_lut');
% imwrite(surround_view,'20190226_datong_surround_view.jpg');
% save('20190312_guan_surround_view_lut.mat','surround_view_lut');
% imwrite(surround_view,'20190312_guan_surround_view.jpg');
save(matFile,'surround_view_lut');
imwrite(surround_view,imgFile);

%% For Ros
lut_uv_front = ((lut_u_front-1)*1280+lut_v_front-1)';
lut_uv_front = lut_uv_front(:);
lut_valid_front = lut_valid_front';
lut_valid_front = lut_valid_front(:);

lut_uv_right = ((lut_u_right-1)*1280+lut_v_right-1)';
lut_uv_right = lut_uv_right(:);
lut_valid_right = lut_valid_right';
lut_valid_right = lut_valid_right(:);

lut_uv_back = ((lut_u_back-1)*1280+lut_v_back-1)';
lut_uv_back = lut_uv_back(:);
lut_valid_back = lut_valid_back';
lut_valid_back = lut_valid_back(:);

lut_uv_left = ((lut_u_left-1)*1280+lut_v_left-1)';
lut_uv_left = lut_uv_left(:);
lut_valid_left = lut_valid_left';
lut_valid_left = lut_valid_left(:);

lut1 = zeros(top_size_m_pixel*top_size_n_pixel,1);
lut2 = zeros(top_size_m_pixel*top_size_n_pixel,1);

mask = lut_valid_front.*(lut1==0);
lut1 = lut1+mask*4;
lut2 = lut2+lut_uv_front.*mask;

mask = lut_valid_right.*(lut1==0);
lut1 = lut1+mask*3;
lut2 = lut2+lut_uv_right.*mask;

mask = lut_valid_back.*(lut1==0);
lut1 = lut1+mask*2;
lut2 = lut2+lut_uv_back.*mask;

mask = lut_valid_left.*(lut1==0);
lut1 = lut1+mask*1;
lut2 = lut2+lut_uv_left.*mask;

lut1 = 4-lut1;

lut1 = uint32(lut1);
lut2 = uint32(lut2*3);

lut1 = bitshift(lut1,24);
lut = bitor(lut1,lut2);


% fileID = fopen('20190312_guan_surround_view_lut.bin','w');
fileID = fopen(lutFile,'w');
% fwrite(fileID,lut1,'uint8');
% fwrite(fileID,lut2,'uint32');
fwrite(fileID,lut,'uint32');
fclose(fileID);

ext_front = generate4x4(car_to_front_offset_mm,car_to_front_rotate,rrt_front);
ext_right = generate4x4(car_to_right_offset_mm,car_to_right_rotate,rrt_right);
ext_back  = generate4x4(car_to_back_offset_mm ,car_to_back_rotate ,rrt_back );
ext_left  = generate4x4(car_to_left_offset_mm ,car_to_left_rotate ,rrt_left );
ext_top = [top_to_car_rotate,-top_to_car_rotate*top_to_car_offset_mm;0,0,1]*[top_mm_per_pixel,0,0;0,top_mm_per_pixel,0;0,0,1]*eye(3);

car2top = inv(ext_top);

fileID = fopen('ext.txt','w');
fprintf(fileID,'ext_front\n');
for i=1:4
    for j=1:4
        fprintf(fileID,'%f ',ext_front(i,j));
    end
    fprintf(fileID,'\n');
end
fprintf(fileID,'ext_right\n');
for i=1:4
    for j=1:4
        fprintf(fileID,'%f ',ext_right(i,j));
    end
    fprintf(fileID,'\n');
end
fprintf(fileID,'ext_back\n');
for i=1:4
    for j=1:4
        fprintf(fileID,'%f ',ext_back(i,j));
    end
    fprintf(fileID,'\n');
end
fprintf(fileID,'ext_left\n');
for i=1:4
    for j=1:4
        fprintf(fileID,'%f ',ext_left(i,j));
    end
    fprintf(fileID,'\n');
end
fprintf(fileID,'ext_top\n');
for i=1:3
    for j=1:3
        fprintf(fileID,'%f ',ext_top(i,j));
    end
    fprintf(fileID,'\n');
end

fclose(fileID);



%% 生成四个bin文件
if(generate_bin_file == 1)
    gen_car2top_lut2(ext_front, bin_file_front, calib_data_front.ocam_model, car2top, pixel_size(1), is_cut);
    gen_car2top_lut2(ext_right, bin_file_right, calib_data_right.ocam_model, car2top, pixel_size(1), is_cut);
    gen_car2top_lut2(ext_back, bin_file_rear, calib_data_back.ocam_model, car2top, pixel_size(1), is_cut);
    gen_car2top_lut2(ext_left, bin_file_left, calib_data_left.ocam_model, car2top, pixel_size(1), is_cut);
end



%% Functions
function [lut_u_cam,lut_v_cam,lut_valid_cam] = generate_lut_v1( ... 
    top_size_pixel,top_mm_per_pixel, ...
    top_to_car_offset_mm,top_to_car_rotate, ...
    car_to_pat_offset_mm,car_to_pat_rotate, ...
    rrt_cam,ocam_model_cam, ...
    input_size_pixel)
[m_rel_top_pixel,n_rel_top_pixel] = meshgrid(1:top_size_pixel(1),1:top_size_pixel(2));
mn_rel_top_pixel = [m_rel_top_pixel(:),n_rel_top_pixel(:)]';
mn_rel_top_mm = mn_rel_top_pixel*top_mm_per_pixel;
xy_rel_car_mm = top_to_car_rotate*(mn_rel_top_mm-repmat(top_to_car_offset_mm,1,size(mn_rel_top_mm,2)));
xy_rel_pat_mm = car_to_pat_rotate*(xy_rel_car_mm-repmat(car_to_pat_offset_mm,1,size(xy_rel_car_mm,2)));
xyp_rel_pat_mm = [xy_rel_pat_mm;ones(1,size(xy_rel_pat_mm,2))];
xyz_rel_cam_mm = rrt_cam*xyp_rel_pat_mm;
% uv_rel_cam_pixel = world2cam(xyz_rel_cam_mm,ocam_model_cam);
uv_rel_cam_pixel = world2cam_fast(xyz_rel_cam_mm,ocam_model_cam);
uv_rel_cam_pixel = round(uv_rel_cam_pixel);
uv_rel_cam_pixel_valid = ...
    1<=uv_rel_cam_pixel(1,:) & uv_rel_cam_pixel(1,:)<=input_size_pixel(1) & ...
    1<=uv_rel_cam_pixel(2,:) & uv_rel_cam_pixel(2,:)<=input_size_pixel(2);
lut_u_cam = reshape(uv_rel_cam_pixel(1,:),top_size_pixel(2),top_size_pixel(1))';
lut_v_cam = reshape(uv_rel_cam_pixel(2,:),top_size_pixel(2),top_size_pixel(1))';
lut_valid_cam = reshape(uv_rel_cam_pixel_valid,top_size_pixel(2),top_size_pixel(1))';
end

function res = generate4x4( ... 
    car_to_pat_offset_mm,car_to_pat_rotate, ...
    rrt_cam)
res = eye(4);

r1 = rrt_cam(:,1);
r2 = rrt_cam(:,2);
r3 = cross(r1,r2);
t = rrt_cam(:,3);
rrt_4x4 = [r1,r2,r3,t;0,0,0,1];
res = (rrt_4x4^-1)*res;

car_to_pat_4x4 = [car_to_pat_rotate,[0;0],-car_to_pat_rotate*car_to_pat_offset_mm;0,0,1,0;0,0,0,1];
res = (car_to_pat_4x4^-1)*res;

end

function top_view_cam = generate_top_view( ...
    input_image,top_size_pixel, ...
    lut_u_cam,lut_v_cam,lut_valid_cam)
top_size_m_pixel = top_size_pixel(1);
top_size_n_pixel = top_size_pixel(2);
input_image_depth = size(input_image,3);
top_view_cam = zeros(top_size_m_pixel,top_size_n_pixel,input_image_depth);
% for m = 1:top_size_m_pixel
%     for n = 1:top_size_n_pixel
%         if lut_valid_cam(m,n)
%             top_view_cam(m,n,:) = input_image(lut_u_cam(m,n),lut_v_cam(m,n),:);
%         end
%     end
% end
lut_u_cam(~lut_valid_cam) = 1;
lut_v_cam(~lut_valid_cam) = 1;
ind = sub2ind(size(input_image),lut_u_cam(:),lut_v_cam(:));
input_image = reshape(input_image,size(input_image,1)*size(input_image,2),size(input_image,3));
top_view_cam(:) = input_image(ind,:);
top_view_cam(repmat(~lut_valid_cam,1,1,input_image_depth)) = 0;
end

function surround_view = generate_surround_view( ...
    top_view_front,lut_valid_front, ...
    top_view_right,lut_valid_right, ...
    top_view_back,lut_valid_back, ...
    top_view_left,lut_valid_left)
top_view_depth = size(top_view_front,3);
surround_view = (top_view_front+top_view_right+top_view_back+top_view_left)./ ...
    repmat(lut_valid_front+lut_valid_right+lut_valid_back+lut_valid_left,1,1,top_view_depth);
end

function show_four_images(image_front,image_right,image_back,image_left)
figure;
subplot(2,2,1);
imshow(image_front);
subplot(2,2,2);
imshow(image_right);
subplot(2,2,3);
imshow(image_back);
subplot(2,2,4);
imshow(image_left);
end

function status = valid_pixel_coordinate(coordinate,image_size)
status = 1<=coordinate(1) && coordinate(1)<=image_size(1) && ...
    1<=coordinate(2) && coordinate(2)<=image_size(2);
end