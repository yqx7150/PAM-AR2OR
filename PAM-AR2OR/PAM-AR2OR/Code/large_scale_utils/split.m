input_filename = '/Users/cyy/Desktop/ar/GT.jpeg';
% 读取原始图像
largeImage = imread(input_filename);
% 假设已经加载了一个名为 'largeImage' 的大图
% 大图的尺寸应该是1228x985像素，根据前面的计算

% 初始化参数
tileSize = 256;      % 小图的尺寸
overlap = 56; %26        % 重叠的像素数
numRows = 5;  %5       % 行数
numCols = 7;  %6       % 列数

% 预分配一个包含裁剪图像的cell数组
croppedImages = cell(numRows, numCols);

% 开始裁剪操作
for i = 0:numRows-1
    for j = 0:numCols-1
        startRow = 1 + i * (tileSize - overlap);
        startCol = 1 + j * (tileSize - overlap);
        endRow = startRow + tileSize - 1;
        endCol = startCol + tileSize - 1;
        croppedImages{i+1, j+1} = largeImage(startRow:endRow, startCol:endCol);
    end
end

% 如果需要，可以展示或保存裁剪后的图像
for i = 1:numRows
    for j = 1:numCols
        % figure;
        % imshow(croppedImages{i, j});
        % title(sprintf('Tile %d-%d', i, j));
        % 可以选择保存裁剪后的图像
        imwrite(croppedImages{i, j}, sprintf('/Users/cyy/Desktop/ar/GT/tile_%d_%d.png', i, j));
    end
end
