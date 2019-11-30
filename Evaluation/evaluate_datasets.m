function measure = evaluate_datasets(ground_truth_path, estimation_path)
    measures = [];
    for f = dir(strcat(estimation_path,filesep,"*.bmp"))
        f.name
        f_name = f.name;
        e_mask = strcat(estimation_path,filesep,f_name);
        gt_mask = strcat(ground_truth_path,filesep,f_name);
        map_gt=double(imread(gt_mask));
        map_est = double(imread(e_mask));
        measure = f_measure(map_gt,map_est);
        measures = [measures measure];
    end
    measure = mean(measures);
end