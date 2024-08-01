from PIL import Image
import os
import numpy as np
import matplotlib.pyplot as plt
import cv2
import os.path
from scipy.signal import convolve2d


def create_point_img(num, save_dir):
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    # Initialize a 256x256 empty matrix
    WIDTH, HEIGHT = 256, 256

    for cnt in range(num):
        img_matrix = np.zeros((WIDTH, HEIGHT), dtype=np.uint8)
        # 1～6组的点
        point_num = np.random.randint(1, 10)

        for i in range(point_num):
            # 横向还是纵向(0：横向，1纵向)
            xory = np.random.randint(0, 2)
            # 间隔多少
            interval = np.random.randint(0, 20)
            # 坐标位置
            if xory:
                # 横向
                x = np.random.randint(10, WIDTH-interval)
                y = np.random.randint(10, HEIGHT)
                img_matrix[y, x] = 255
                img_matrix[y, x+interval] = 255
            else:
                # 纵向
                x = np.random.randint(10, WIDTH)
                y = np.random.randint(10, HEIGHT-interval)
                img_matrix[y, x] = 255
                img_matrix[y+interval, x] = 255
        # 把numpy转为PIL.Image保存
        # img = Image.fromarray(img_matrix)
        # img.save(os.path.join(save_dir, 'point_{}.png'.format(cnt)))
        cv2.imwrite(os.path.join(
            save_dir, 'point_{}.png'.format(cnt)), img_matrix)


create_point_img(num=100, save_dir='/Users/cyy/Desktop/111_cv2')
