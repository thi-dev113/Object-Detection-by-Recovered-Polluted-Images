function output = addSpeckleNoise(input, variance)
    input = im2double(input);
    noise = sqrt(variance) * randn(size(input)); % Generate Gaussian noise
    output = input + input .* noise; % Add multiplicative noise
    output = im2uint8(mat2gray(output));
end
