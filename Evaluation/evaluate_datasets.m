function measure = evaluate_datasets(ground_truth_path, estimation_path)
    measures = [];
    estimatedFiles = findFiles(estimation_path, 'bmp');
    
    for k = 1:length(estimatedFiles)
        eMPath = char(estimatedFiles(k));
        parts = strsplit(eMPath, '/');
        partsSizes = size(parts);
        fname = parts(partsSizes(2));
        gMPath = strcat(ground_truth_path, fname{1});
        eM = imread(eMPath);
        gM = imread(gMPath);
        eM = double(eM);
        gM = double(gM);
        measure = f_measure(gM,eM);
        measures = [measures measure];
        %fprintf('%s -> %3.4f\n',f_name,measure);
    end
    measure = mean(measures);
end