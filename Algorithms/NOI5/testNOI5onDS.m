function testNOI5onDS(ds_path, estimation_path)
files = dir(strcat(ds_path,filesep,'*.tif'));
for k = 1:length(files)
    tic
    i_name = files(k).name;
    i_path = strcat(ds_path,filesep,i_name);
    
    o_name = strrep(i_name,'.tif','.bmp');
    o_path = strcat(estimation_path,filesep,o_name);
    run(i_path, o_path);
    toc
end
end