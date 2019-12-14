function measure = evaluate_datasets(ground_truth_path, estimation_path)
    estimatedFiles = findFiles(estimation_path, 'bmp');
    measures = zeros(1,length(estimatedFiles), 'int8');
    
    for k = 1:length(estimatedFiles)
        eMPath = char(estimatedFiles(k));
        parts = strsplit(eMPath, '/');
        partsSizes = size(parts);
        fname = parts(partsSizes(2));
        gMPath = strcat(ground_truth_path, fname{1});
        eM = imread(eMPath);
        gM = imread(gMPath);
        measure = f_measure(gM,eM);
        measures(k) = measure;
        fprintf('%s -> %3.4f\n',fname{1},measure);
    end
    measure = mean(measures);
end

% function measure = evaluate_datasets(ground_truth_path, estimation_path)
%     measures = [];
%     files = dir(strcat(estimation_path,filesep,"*.bmp"));
%     for k = 1:length(files)
%         f_name = files(k).name;
%         e_mask = strcat(estimation_path,filesep,f_name);
%         gt_mask = strcat(ground_truth_path,filesep,f_name);
%         map_gt=double(imread(gt_mask));
%         map_est = double(imread(e_mask));
%         measure = f_measure(map_gt,map_est);
%         measures = [measures measure];
%         fprintf('%s -> %3.4f\n',f_name,measure);
%     end
%     measure = mean(measures);
% end