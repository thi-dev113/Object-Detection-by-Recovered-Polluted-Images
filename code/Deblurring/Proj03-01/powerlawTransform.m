function output = powerlawTransform(input, c, r)
img = double(input);
transformedImg = c * (img .^ r);
max_element = max(transformedImg(:));
min_element = min(transformedImg(:));
epsilon = 1e-10;
output = single((transformedImg - min_element) / (max_element - min_element + epsilon));
end

