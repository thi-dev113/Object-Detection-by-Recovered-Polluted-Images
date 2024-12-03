function t_map = estimate_transmission_map(fogged_image, dark_channel, A)
    % Estimate transmission map using dark channel
    omega = 0.95;  % Regularization parameter
    t_map = 1 - omega * dark_channel;
end