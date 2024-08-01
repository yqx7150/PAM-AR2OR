% 设置：噪声水平
SNR = 35;

% 设置：FWHM
pixelSize_um = 5; % 每像素代表的微米数
FWHM_um = 55; % 半高全宽（微米单位）
FWHM_pixels = FWHM_um / pixelSize_um; % 将FWHM转换为像素单位

% 计算σ值
sigma_pixels = FWHM_pixels / (2*sqrt(2*log(2)));

% 定义图片大小
imageSize = [256, 256];

% 创建网格：-128～127
[x, y] = meshgrid(-floor(imageSize(2)/2):floor(imageSize(2)/2)-1, ...
                  -floor(imageSize(1)/2):floor(imageSize(1)/2)-1);

% 构建二维高斯PSF核，中心在图片中心
PSF = exp(-(x.^2 + y.^2) / (2*sigma_pixels^2));
PSF = PSF / sum(PSF(:)); % 归一化，确保总和为1

% 获取输入图像文件夹路径
inputFolderPath = '/home/y/桌面/IR-SDE-data/5_15_test/GT/';

% 获取输出图像文件夹路径
outputFolderPath = '/home/y/桌面/IR-SDE-data/5_15_test/ceshi/';

% 如果输出文件夹不存在，则创建它
if ~exist(outputFolderPath, 'dir')
    mkdir(outputFolderPath);
end

% 读取输入文件夹中的所有.png文件
inputFiles = dir(fullfile(inputFolderPath, '*.png'));

% 遍历每个输入图像文件
for i = 1:numel(inputFiles)
    % 读取图像
    imagePath = fullfile(inputFolderPath, inputFiles(i).name);
    image = imread(imagePath);
    
    % 执行二维卷积
    convResult = conv2(image, PSF, 'same');

    img = double(convResult);

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
    
    % 构建输出文件路径
    [~, filename, ext] = fileparts(inputFiles(i).name);
    outputImagePath = fullfile(outputFolderPath, [filename, ext]);
    
    % 保存卷积结果图像
    imwrite(mat2gray(noisy_img), outputImagePath);
    disp(outputImagePath);
end
