% ---- Fog Generation Function ----
function fogged_image = apply_fog(img, t_map, A)
    % Replicate A to match the image size for element-wise multiplication
    A = reshape(A, 1, 1, 3);  % Make A a 1x1x3 vector
    fogged_image = img .* t_map(:, :, ones(1, 3)) + A .* (1 - t_map(:, :, ones(1, 3)));  % Element-wise multiplication
end