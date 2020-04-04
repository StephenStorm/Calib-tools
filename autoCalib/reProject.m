function [f_rM,l_rM] = reProject
    f_rM = zeros(2,27,2);
    l_rM = zeros(2,42,2);
    para_front={'./calib_model/front_model.mat','./calib_model/rear_model.mat'};
    para_left ={'./calib_model/left_model.mat','./calib_model/right_model.mat'};
    for i=1:2
        M = load('./calib_model/front_pos.txt');
        tmp = load(para_front{i});
        tmp = tmp.calib_data;
        RRfin = tmp.RRfin;
        ocam_model = tmp.ocam_model;
        ocam_model.pol = findinvpoly(ocam_model.ss,sqrt((ocam_model.width/2)^2+(ocam_model.height/2)^2));
        M = RRfin * M;
        f_rM(:,:,i) = world2cam_fast(M,ocam_model);
    end
    for i=1:2
        M = load('./calib_model/lr_pos.txt');
        tmp = load(para_left{i});
        tmp = tmp.calib_data;
        RRfin = tmp.RRfin;
        ocam_model = tmp.ocam_model;
        ocam_model.pol = findinvpoly(ocam_model.ss,sqrt((ocam_model.width/2)^2+(ocam_model.height/2)^2));
        M = RRfin * M;
        l_rM(:,:,i) = world2cam_fast(M,ocam_model);
    end
end




