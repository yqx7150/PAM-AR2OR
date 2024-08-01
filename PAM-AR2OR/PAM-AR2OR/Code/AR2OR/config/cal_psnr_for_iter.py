import cv2
import os
from skimage.metrics import peak_signal_noise_ratio, structural_similarity

def compute_psnr(img1, img2):
    psnr = peak_signal_noise_ratio(img1, img2)

    return psnr


def compute_ssim(img1, img2):
    ssim = structural_similarity(img1, img2)

    return ssim

def cal_psnr_for_iter_func(results_root):
    folder_path = os.path.join(results_root, 'state')
    HQ_dir = os.path.join(results_root,"test_dataset", "HQ")
    reference_image_path = os.listdir(HQ_dir)[0]
    reference_image_path = os.path.join(HQ_dir, reference_image_path)
    print(reference_image_path ,"==========================================")
    output_file_path = os.path.join(results_root, "state.txt")

    reference_image = cv2.imread(reference_image_path, cv2.IMREAD_UNCHANGED)

    with open(output_file_path, 'w') as file:
        files = sorted(os.listdir(folder_path), key=lambda x: int(x.split('.')[0]))
        for idx, filename in enumerate(files):
            file_path = os.path.join(folder_path, filename)
            image = cv2.imread(file_path, cv2.IMREAD_UNCHANGED)

            if image is None:
                file.write(f"Error loading image {filename}\n")
                continue

            image = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
            psnr_value = compute_psnr(reference_image, image)

            file.write(f"filename: {filename} =====>PSNR: {psnr_value}\n")
        file.write('\n')
        file.write('----------------------------------------\n')
        file.write('----------------------------------------\n')
        file.write('\n')
        for idx, filename in enumerate(files):
            file_path = os.path.join(folder_path, filename)
            image = cv2.imread(file_path, cv2.IMREAD_UNCHANGED)

            if image is None:
                file.write(f"Error loading image {filename}\n")
                continue

            image = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
            ssim_value = compute_ssim(reference_image, image)

            file.write(f"filename: {filename} =====>SSIM: {ssim_value}\n")