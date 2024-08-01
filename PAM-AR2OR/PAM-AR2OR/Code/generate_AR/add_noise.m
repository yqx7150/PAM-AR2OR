% 定义源文件夹和目标文件夹
sourceFolder = '/home/y/桌面/IR-SDE-data/5_15_test/55um_0db/'; % 包含TIFF文件的文件夹
targetFolder = '/home/y/桌面/IR-SDE-data/5_15_test/55um_15db/'; % 保存PNG文件的目标文件夹

% 检查目标文件夹是否存在，如果不存在，则创建
if ~exist(targetFolder, 'dir')
    mkdir(targetFolder);
end

% 获取源文件夹中所有TIFF文件的列表
filePattern = fullfile(sourceFolder, '*.png'); % 也可以使用 '*.tiff' 如果你的文件扩展名是.tiff
allFiles = dir(filePattern);


SNR = 15;
disp(SNR);
% 遍历所有TIFF文件
for k = 1:length(allFiles)
    baseFileName = allFiles(k).name;
    fullFileName = fullfile(sourceFolder, baseFileName);
    disp(fullFileName);

    % 读取TIFF文件
    img = imread(fullFileName);

    % 构建PNG文件的完整路径名
    [filePath, name, ~] = fileparts(fullFileName);
    targetFileName = fullfile(targetFolder, [name '.png']);
    img = double(img);

    img = (img - min(min(img))) / (max(max(img)) - min(min(img)));
    img = img * 255;

    [noisy_img,snr_v] = addNoise(img, SNR, 'peak');
    %将像素值限制在0-255范围内
    noisy_img = max(0, min(255, noisy_img));
    % 显示加噪后的图像
    imshow(uint8(noisy_img),[]);
    noisy_img = (noisy_img - min(min(noisy_img))) / (max(max(noisy_img)) - min(min(noisy_img)));
    noisy_img = noisy_img * 255;
    noisy_img=uint8(noisy_img);
    imwrite(noisy_img, targetFileName);

    % 输出转换状态
    fprintf('已将文件 %s 转换为PNG格式。\n', baseFileName);
end

% 转换完成
fprintf('所有文件加噪完成。\n');