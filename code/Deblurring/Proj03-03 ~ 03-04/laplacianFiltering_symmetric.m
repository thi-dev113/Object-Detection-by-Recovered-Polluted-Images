function [output, scaledLaplacian] = laplacianFiltering_symmetric(input, laplacianMask, scale)
transformed_img = spatialFiltering_symmetric(input, laplacianMask);
scaledLaplacian = single(transformed_img) .* scale;
output = single(input) + scaledLaplacian;

max_element = max(output(:));
min_element = min(output(:));
epsilon = 1e-10;
output = single((output - min_element) / (max_element - min_element + epsilon));

end

