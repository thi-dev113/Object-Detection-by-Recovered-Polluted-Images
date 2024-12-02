%% Proj02-03: Zooming and Shrinking Images by Pixel Replication

% originalImage: 還沒 resize 的原影像
% scalingFactor: resize 的 scale (例如要放大為兩倍: 2；縮小為一半: 1/2)
% resizedImage: resize 後的影像
% formula source: https://www.ajdesigner.com/phpinterpolation/bilinear_interpolation_equation.php

function [resizedImage] = resizeImage_bilinear(originalImage, scalingFactor)
    img = imread(originalImage);
    [rows, cols, num_channels] = size(img);
    new_rows = uint16(floor(rows * scalingFactor));
    new_cols = uint16(floor(cols * scalingFactor));
    resizedImage = zeros(new_rows, new_cols, num_channels, 'like', img);
    
    % Using Repeated linear interpolation
    warning('off', 'all');

    for resized_i=1 : new_rows
        for resized_j=1 : new_cols
            x = double(resized_i) / scalingFactor + 1;
            y = double(resized_j) / scalingFactor + 1;

            % Boundary check
            x = min(rows, x);
            y = min(cols, y);

            x1 = max(1, floor(x));
            x2 = min(rows, x1+1);
            y1 = max(1, floor(y));
            y2 = min(cols, y1+1);
            
            f11 = double(img(x1, y1));
            f12 = double(img(x1, y2));
            f21 = double(img(x2, y1));
            f22 = double(img(x2, y2));
            
            A = [f11, f12, f21, f22];
            B = [ x2*y2,-y2, -x2, 1;
                 -x2*y1, y1, x2, -1;
                 -x1*y2, y2, x1, -1;
                  x1*y1, -y1, -x1, 1;];
            C = [1; x; y; x*y;];
            
            resized_value = A * B * C;
            resizedImage(resized_i, resized_j) = round(resized_value);
        end
    end

    warning('on', 'all');
    resizedImage = uint8(resizedImage);
end

