function output = removeSpeckleNoise(input, noise_variance)
    input = im2double(input);
    output = wiener2(input, [5, 5], noise_variance); % Wiener filter
    output = im2uint8(output);
end