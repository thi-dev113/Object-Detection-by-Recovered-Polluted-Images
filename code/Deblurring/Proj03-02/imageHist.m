function histVector = imageHist(input)
frequency = zeros(1, 255);
[rows, cols] = size(input);
for row=1 : rows
    for col=1 : cols
        value = input(row, col) + 1; % the index of an array start from 1
        frequency(value) = frequency(value) + 1;
    end
end

histVector = single(frequency);
end

