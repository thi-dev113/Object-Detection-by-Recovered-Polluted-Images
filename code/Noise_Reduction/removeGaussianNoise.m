function output = removeGaussianNoise(input, sigma)
    input = im2double(input);
    h = fspecial('gaussian', [15, 15], sigma); % Gaussian filter
    output = imfilter(input, h, 'same'); % Apply filter
    output = im2uint8(output); % Convert back to uint8
end
