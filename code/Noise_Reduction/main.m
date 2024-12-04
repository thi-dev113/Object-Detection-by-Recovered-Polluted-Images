% Load an image
clc, clearvars;
img = imread('lamp.jpg');
img = im2gray(img); % Convert to grayscale

% Experimentation parameters (10 values each)
gaussian_variances = linspace(0.01, 0.1, 10); % Gaussian noise variances
salt_pepper_probs = linspace(0.01, 0.1, 10); % Salt-and-pepper noise probabilities
speckle_variances = linspace(0.02, 0.2, 10); % Speckle noise variances

% Folder to save results
output_dir = 'recovered_images';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

output_dir2 = 'polluted_images';
if ~exist(output_dir2, 'dir')
    mkdir(output_dir2);
end

% Gaussian Noise Experimentation
for i = 1:length(gaussian_variances)
    g_var = gaussian_variances(i);
    noisy_gaussian = addGaussianNoise(img, 0, g_var);
    denoised_gaussian = removeGaussianNoise(noisy_gaussian, g_var);
    
    % Save images
    imwrite(noisy_gaussian, fullfile(output_dir2, sprintf('GaussianNoise_%.2f.png', g_var)));
    imwrite(denoised_gaussian, fullfile(output_dir, sprintf('Denoised_Gaussian_%.2f.png', g_var)));
end

% Salt-and-Pepper Noise Experimentation
for i = 1:length(salt_pepper_probs)
    sp_prob = salt_pepper_probs(i);
    noisy_salt_pepper = addImpulseNoise(img, sp_prob, sp_prob);
    denoised_salt_pepper = removeImpulseNoise(noisy_salt_pepper);
    
    % Save images
    imwrite(noisy_salt_pepper, fullfile(output_dir2, sprintf('SaltPepperNoise_%.2f.png', sp_prob)));
    imwrite(denoised_salt_pepper, fullfile(output_dir, sprintf('Denoised_SaltPepper_%.2f.png', sp_prob)));
end

% Speckle Noise Experimentation
for i = 1:length(speckle_variances)
    s_var = speckle_variances(i);
    noisy_speckle = addSpeckleNoise(img, s_var);
    denoised_speckle = removeSpeckleNoise(noisy_speckle, s_var);
    
    % Save images
    imwrite(noisy_speckle, fullfile(output_dir2, sprintf('SpeckleNoise_%.2f.png', s_var)));
    imwrite(denoised_speckle, fullfile(output_dir, sprintf('Denoised_Speckle_%.2f.png', s_var)));
end

% Compress the results folder
zipFileName = 'NoiseReduction_recovered.zip';
zip(zipFileName, output_dir);
zipFileName2 = 'NoiseReduction_polluted.zip';
zip(zipFileName2, output_dir2);

disp(['All processed images have been saved and zipped into: ', zipFileName]);
disp(['All processed images have been saved and zipped into: ', zipFileName2]);
