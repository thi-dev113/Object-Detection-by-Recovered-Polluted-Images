function [output, T] = histEqualization(input)
histVector = imageHist(input);
[M, N] = size(input);
pdf = histVector ./ (M*N);
cdf = cumsum(pdf);
T = uint8((256-1) * cdf);
transformed_image = zeros(M, N);

for row=1 : M
    for col=1 : N
        intensity_value = input(row, col) + 1;
        transformed_image(row, col) = T(intensity_value);
    end
end

output = uint8(transformed_image);
end



