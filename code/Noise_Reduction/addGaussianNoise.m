function output = addGaussianNoise(input, mu, sigma)
    input = im2double(input); % Convert to double for adding noise
    noise = sigma * randn(size(input)) + mu; % Generate Gaussian noise
    output = input + noise; % Add noise
    output = im2uint8(mat2gray(output)); % Scale and convert back to uint8
end
