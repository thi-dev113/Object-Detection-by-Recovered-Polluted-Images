function output = removeImpulseNoise(input)
    output = medfilt2(input, [3, 3]); % Apply 3x3 median filter
end
