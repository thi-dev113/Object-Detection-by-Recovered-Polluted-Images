function output = logTransform(input, c)
img = double(input);
transformed_img = c * log(1 + img);
output = single(transformed_img ./ 255);
end

