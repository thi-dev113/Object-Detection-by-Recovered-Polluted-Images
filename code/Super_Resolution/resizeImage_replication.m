%% Proj02-04: Zooming and Shrinking Images by Pixel Replication

% originalImage: 還沒 resize 的原影像
% scalingFactor: resize 的 scale (例如要放大為兩倍: 2；縮小為一半: 1/2)
% resizedImage: resize 後的影像

function [resizedImage] = resizeImage_replication(originalImage,scalingFactor)
    img = imread(originalImage);
    if scalingFactor > 1
        resizedImage = kron(double(img), ones(scalingFactor));
        resizedImage = uint8(resizedImage);
    end

    if scalingFactor == 1
        resizedImage = img;
    end

    if scalingFactor < 1
        newFactor = round(1 / scalingFactor);
        resizedImage = img(1:newFactor:end, 1:newFactor:end);
    end
end

