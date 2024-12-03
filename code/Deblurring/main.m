% Load Image
img = imread('Fig0338(a).tif'); % Replace 'example.jpg' with your image file
img_gray = im2double(img); % Convert to grayscale if it's a color image

% Averaging Filter
kernel_size = 5; % Define kernel size
avg_kernel = ones(kernel_size) / (kernel_size^2);
blur_avg = imfilter(img_gray, avg_kernel, 'same');

% Gaussian Blur
sigma = 2; % Standard deviation
gauss_kernel = fspecial('gaussian', [kernel_size kernel_size], sigma);
blur_gauss = imfilter(img_gray, gauss_kernel, 'same');

% Motion Blur
motion_kernel = fspecial('motion', 20, 45); % Length and angle
blur_motion = imfilter(img_gray, motion_kernel, 'same');

% Display Results
figure(1);
subplot(2,2,1), imshow(img_gray), title('Original Image');
subplot(2,2,2), imshow(blur_avg), title('Averaging Blur');
subplot(2,2,3), imshow(blur_gauss), title('Gaussian Blur');
subplot(2,2,4), imshow(blur_motion), title('Motion Blur');


% Deblurring Example: Wiener Filter
blurred_img = imfilter(img_gray, gauss_kernel, 'same'); % Simulate Gaussian blur
noise_var = 0.01; % Assume noise variance
deblur_wiener = deconvwnr(blurred_img, gauss_kernel, noise_var);

% Deblurring Example: Lucy-Richardson
num_iterations = 15; % Number of iterations
deblur_lucy = deconvlucy(blurred_img, gauss_kernel, num_iterations);

% Deblurring Example: Log-transform
num_iterations = 15; % Number of iterations
deblur_lucy = deconvlucy(blurred_img, gauss_kernel, num_iterations);

% Deblurring Example: Powerlaw-transform
num_iterations = 15; % Number of iterations
deblur_lucy = deconvlucy(blurred_img, gauss_kernel, num_iterations);

% Display Results
figure(2);
subplot(1,3,1), imshow(blurred_img), title('Blurred Image');
subplot(1,3,2), imshow(deblur_wiener), title('Wiener Filter Deblur');
subplot(1,3,3), imshow(deblur_lucy), title('Lucy-Richardson Deblur');



