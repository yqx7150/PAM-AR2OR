crop_and_save_images('/Users/cyy/Desktop/ar/GT', '/Users/cyy/Desktop/ar/GT_cropped');

function crop_and_save_images(inputFolder, outputFolder)
    % 检查输出文件夹是否存在，如果不存在则创建
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    % 获取输入文件夹中所有的图像文件
    filePattern = fullfile(inputFolder, '*.png');  % 你可以根据需要修改文件类型
    pngFiles = dir(filePattern);

    % 设置裁剪参数
    cropSize = 28;  %13  % 每边要裁剪的像素数
    newDim = 256 - 2*cropSize;  % 新图像的尺寸

    % 遍历每个文件，进行裁剪，并保存到新的文件夹
    for k = 1:length(pngFiles)
        baseFileName = pngFiles(k).name;
        fullFileName = fullfile(inputFolder, baseFileName);
        img = imread(fullFileName);  % 读取图像

        % 裁剪图像
        croppedImg = img(cropSize+1:end-cropSize, cropSize+1:end-cropSize);

        % 构建输出文件名，并保存裁剪后的图像
        outputFileName = fullfile(outputFolder, baseFileName);
        imwrite(croppedImg, outputFileName);
    end

    fprintf('All images have been cropped and saved to %s.\n', outputFolder);
end
