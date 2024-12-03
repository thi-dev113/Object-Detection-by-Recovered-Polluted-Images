% Load the original image
clc, clear;
img = imread('bottle.jpg');  % Replace with your image file
img = im2double(img);  % Normalize image to [0, 1]

% Folder to save results
output_dir = 'recovered_images';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

output_dir2 = 'polluted_images';
if ~exist(output_dir2, 'dir')
    mkdir(output_dir2);
end

% Fogging Parameters for experiments
transmission_maps = {ones(size(img, 1), size(img, 2)) * 0.5, ...        % Uniform transmission map
                      ones(size(img, 1), size(img, 2)) * 0.7, ...        % Higher transmission
                      rand(size(img, 1), size(img, 2)) * 0.4};          % Random transmission

atmospheric_lights = {[0.7, 0.7, 0.7], [0.9, 0.9, 0.9], [0.5, 0.5, 0.5]};  % Different atmospheric light values

% Experiment with different Wiener filter window sizes
wiener_sizes = [3, 5, 7];  % Window sizes for Wiener filter

% Iterate over all combinations of parameters
count = 1;  % Image counter for naming saved files
for t = 1:length(transmission_maps)
    for A = 1:length(atmospheric_lights)
        for w = 1:length(wiener_sizes)
            % Apply Fog (Fogging)
            fogged_img = apply_fog(img, transmission_maps{t}, atmospheric_lights{A});

            % Save the fogged image to output_dir2
            fogged_img_filename = sprintf('%s/fogged_%d_%d_%d.jpg', output_dir2, t, A, w);
            imwrite(fogged_img, fogged_img_filename);

            % Apply Defogging using Dark Channel Prior (DCP)
            defogged_img_dcp = defog_dcp(fogged_img);
            
            % Apply Defogging using Adaptive Filtering (Wiener Filter and CLAHE)
            defogged_img_adaptive = adaptive_filter_defog(fogged_img, wiener_sizes(w));

            % Save the defogged images to output_dir
            defogged_img_dcp_filename = sprintf('%s/defogged_dcp_%d_%d_%d.jpg', output_dir, t, A, w);
            defogged_img_adaptive_filename = sprintf('%s/defogged_adaptive_%d_%d_%d.jpg', output_dir, t, A, w);
            imwrite(defogged_img_dcp, defogged_img_dcp_filename);
            imwrite(defogged_img_adaptive, defogged_img_adaptive_filename);

            count = count + 1;  % Increment image counter
        end
    end
end

% Compress the results folder
zipFileName = 'Dehazing_recovered.zip';
zip(zipFileName, output_dir);
zipFileName2 = 'Deblurring_polluted.zip';
zip(zipFileName2, output_dir2);

disp(['All processed images have been saved and zipped into: ', zipFileName]);
disp(['All processed images have been saved and zipped into: ', zipFileName2]);