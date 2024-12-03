% ---- Defogging using Adaptive Filtering (with Wiener Filter and CLAHE) ----
function defogged_image = adaptive_filter_defog(fogged_image, wiener_window)
    % Initialize the defogged image as the same size as the input
    defogged_image = zeros(size(fogged_image));
    
    % Apply Wiener filter to each channel (R, G, B)
    for i = 1:3
        defogged_image(:, :, i) = wiener2(fogged_image(:, :, i), [wiener_window wiener_window]);  % Apply Wiener filter to each channel
    end
    
    % After Wiener filtering, enhance the contrast using CLAHE (Contrast-Limited Adaptive Histogram Equalization)
    for i = 1:3
        defogged_image(:, :, i) = adapthisteq(defogged_image(:, :, i), 'ClipLimit', 0.02, 'NumTiles', [8 8]);
    end
end