function output = spatialFiltering_symmetric(input, mask)
max_element = max(input(:));
min_element = min(input(:));
epsilon = 1e-10;
input = single((input - min_element) ./ (max_element - min_element + epsilon));

[input_rows, input_cols] = size(input);
[mask_rows, mask_cols] = size(mask);
padded_rows = (mask_rows-1) / 2;
padded_cols = (mask_cols-1) / 2;
padded_img = padarray(input, [padded_rows, padded_cols], 'symmetric');
transformed_img = zeros(input_rows, input_cols, 'single');

for row = padded_rows+1 : input_rows
    for col = padded_cols+1 : input_cols
        window = single(padded_img(row-padded_rows:row+padded_rows, col-padded_cols:col+padded_cols));
        transformed_img(row-padded_rows, col-padded_cols) = sum(sum(window .* mask));
    end
end


max_element = max(transformed_img(:));
min_element = min(transformed_img(:));
epsilon = 1e-10;
output = single((transformed_img - min_element) ./ (max_element - min_element + epsilon));

end

