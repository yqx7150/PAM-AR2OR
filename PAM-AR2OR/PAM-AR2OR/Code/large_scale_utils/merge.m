input_folder = '/Users/cyy/Desktop/ar/GT_cropped/';
output_filename = '/Users/cyy/Desktop/大图_5_9/GT.png';
num_blocks_horiz = 7; %6
num_blocks_vert = 5; %5
block_size = 200;
total_width = num_blocks_horiz * block_size;
total_height = num_blocks_vert * block_size;

% 初始化一个空矩阵来存放完整图像
full_image = zeros(total_height, total_width, 1, 'uint8');

% 读取并拼接图像块
for i = 1:num_blocks_vert
    for j = 1:num_blocks_horiz
        % 构建图像块的文件名
        block_filename = [input_folder 'tile_' num2str(i) '_' num2str(j) '.png'];
        
        % 读取图像块
        image_block = imread(block_filename);
        
        % 计算在完整图像中的位置
        row_start = (i - 1) * block_size + 1;
        col_start = (j - 1) * block_size + 1;
        
        % 将图像块放入相应位置
        full_image(row_start:row_start + block_size - 1, col_start:col_start + block_size - 1, :) = image_block;
    end
end

% 保存重组后的完整图像
imwrite(full_image, output_filename);