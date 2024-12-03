% Load an image
clc, clear
inputImage = imread('Fig220(a).tif');
inputImage = im2double(inputImage);

% Define scaling factors
scalingFactors = [0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10];

% Folder to save results
outputFolder = 'recovered_images';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

outputFolder2 = 'polluted_images';
if ~exist(outputFolder2, 'dir')
    mkdir(outputFolder2);
end

% Iterate over the scaling factors
for i = 1:length(scalingFactors)
    scale = scalingFactors(i);

    % Downscale the image
    nearestNeighbor_down = imresize(inputImage, scale, 'nearest');
    bilinear_down = imresize(inputImage, scale, 'bilinear');
    bicubic_down = imresize(inputImage, scale, 'bicubic');
    
    % Upscale back to the original size
    nearestNeighbor_up = imresize(nearestNeighbor_down, 1 / scale, 'nearest');
    bilinear_up = imresize(bilinear_down, 1 / scale, 'bilinear');
    bicubic_up = imresize(bicubic_down, 1 / scale, 'bicubic');

    % Save results as images
    imwrite(nearestNeighbor_up, fullfile(outputFolder, sprintf('superRes_NearestNeighbor_Scale%.2f_rec.png', scale)));
    imwrite(bilinear_up, fullfile(outputFolder, sprintf('superRes_Bilinear_Scale%.2f_rec.png', scale)));
    imwrite(bicubic_up, fullfile(outputFolder, sprintf('superRes_Bicubic_Scale%.2f_rec.png', scale)));
    imwrite(nearestNeighbor_down, fullfile(outputFolder2, sprintf('superRes_NearestNeighbor_Scale%.2f_pol.png', scale)));
    imwrite(bilinear_down, fullfile(outputFolder2, sprintf('superRes_Bilinear_Scale%.2f_pol.png', scale)));
    imwrite(bicubic_down, fullfile(outputFolder2, sprintf('superRes_Bicubic_Scale%.2f_pol.png', scale)));
end

% Create a ZIP file containing all saved images for machine learning
zipFileName = 'SuperResolution_recovered.zip';
zip(zipFileName, outputFolder);
zipFileName2 = 'SuperResolution_polluted.zip';
zip(zipFileName2, outputFolder2);

disp(['All processed images have been saved and zipped into: ', zipFileName]);
disp(['All processed images have been saved and zipped into: ', zipFileName2]);
