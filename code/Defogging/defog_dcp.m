% ---- Defogging using Dark Channel Prior (DCP) ----
function defogged_image = defog_dcp(fogged_image)
    % Step 1: Calculate the dark channel of the image
    dark_channel = min(fogged_image, [], 3);
    
    % Step 2: Estimate atmospheric light A
    A = estimate_atmospheric_light(fogged_image, dark_channel);
    
    % Step 3: Estimate the transmission map
    t_map = estimate_transmission_map(fogged_image, dark_channel, A);
    
    % Step 4: Recover the scene radiance
    defogged_image = (fogged_image - A) ./ t_map + A;
end