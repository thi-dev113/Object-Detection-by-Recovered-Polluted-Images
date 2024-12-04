% Load Image
clc, clear
img = imread('Fig0338(a).tif'); 
img_gray = im2double(img);

% Folder to save results
output_dir = 'recovered_images';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

output_dir2 = 'polluted_images';
if ~exist(output_dir2, 'dir')
    mkdir(output_dir2);
end

% Define experimental ranges (Reduced parameters)
noise_var_values = linspace(0.001, 0.1, 5); % 5 noise variances
kernel_size_values = 3:4:19; % 5 kernel sizes (3, 7, 11, 15, 19)
sigma_values = [0.5, 1, 2, 3, 5]; % 5 sigma values for Gaussian
motion_lengths = [5, 15, 25, 35, 50]; % 5 motion blur lengths
fixed_motion_angle = 45; % Fixed motion angle

% Laplacian Mask (constant for all experiments)
laplacianMask = [-1 -1 -1; -1  8 -1; -1 -1 -1];
scale = 1;

% Iterate over noise variance values
for noise_var = noise_var_values
    for kernel_size = kernel_size_values
        % Averaging Blur
        avg_kernel = ones(kernel_size) / (kernel_size^2);
        blur_avg = imfilter(img_gray, avg_kernel, 'same');
        deblur_avg_wiener = deconvwnr(blur_avg, avg_kernel, noise_var);
        deblur_avg_lap = laplacianFiltering(deblur_avg_wiener, laplacianMask, scale);

        imwrite(deblur_avg_lap, fullfile(output_dir, sprintf('Deblurred_Avg_Kernel%d_NoiseVar%.3f_Scale%d.png', kernel_size, noise_var, scale)));
        imwrite(blur_avg, fullfile(output_dir2, sprintf('Blurred_Avg_Kernel%d_NoiseVar%.3f.png', kernel_size, noise_var)));
    end

    for sigma = sigma_values
        % Gaussian Blur
        gauss_kernel = fspecial('gaussian', [15, 15], sigma); % Fixed kernel size
        blur_gauss = imfilter(img_gray, gauss_kernel, 'same');
        deblur_gauss_wiener = deconvwnr(blur_gauss, gauss_kernel, noise_var);
        deblur_gauss_lap = laplacianFiltering(deblur_gauss_wiener, laplacianMask, scale);

        imwrite(deblur_gauss_lap, fullfile(output_dir, sprintf('Deblurred_Gaussian_Sigma%.2f_NoiseVar%.3f_Scale%d.png', sigma, noise_var, scale)));
        imwrite(blur_gauss, fullfile(output_dir2, sprintf('Blurred_Gaussian_Sigma%.2f_NoiseVar%.3f.png', sigma, noise_var)));
    end

    for motion_len = motion_lengths
        % Motion Blur with fixed angle
        motion_kernel = fspecial('motion', motion_len, fixed_motion_angle);
        blur_motion = imfilter(img_gray, motion_kernel, 'same');
        deblur_motion_wiener = deconvwnr(blur_motion, motion_kernel, noise_var);
        deblur_motion_lap = laplacianFiltering(deblur_motion_wiener, laplacianMask, scale);

        imwrite(deblur_motion_lap, fullfile(output_dir, sprintf('Deblurred_Motion_Length%.1f_Angle%.1f_NoiseVar%.3f_Scale%d.png', motion_len, fixed_motion_angle, noise_var, scale)));
        imwrite(blur_motion, fullfile(output_dir2, sprintf('Blurred_Motion_Length%.1f_Angle%.1f_NoiseVar%.3f.png', motion_len, fixed_motion_angle, noise_var)));
    end
end

% Compress the results folder
zipFileName = 'Deblurring_recovered.zip';
zip(zipFileName, output_dir);
zipFileName2 = 'Deblurring_polluted.zip';
zip(zipFileName2, output_dir2);

disp(['All processed images have been saved and zipped into: ', zipFileName]);
disp(['All processed images have been saved and zipped into: ', zipFileName2]);
