function A = estimate_atmospheric_light(fogged_image, dark_channel)
    % Estimate atmospheric light from the dark channel
    [~, idx] = sort(dark_channel(:), 'descend');
    brightest_pixels = idx(1:round(numel(dark_channel) * 0.1));
    A = mean(fogged_image(brightest_pixels));
end