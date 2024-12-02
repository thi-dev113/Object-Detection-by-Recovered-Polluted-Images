%% Section 1 - Proj03_02 Submission
clearvars, clc
originalImage = './Fig0308(a).tif';
img = imread(originalImage);
histVector = imageHist(img);
[output, T] = histEqualization(img);

figure(1);
tiledlayout(1,2);

nexttile
imshow(img);
title("Original Image");
colorbar;

nexttile
imshow(output);
title("Enhanced Image");
colorbar;

figure(2);
tiledlayout(2,2);

nexttile
plot(histVector);
title("HistVector");
xlim([0,255]);

nexttile
stairs(T);
title("histogram equalization transformation function");
xlim([0,255]);

nexttile
enhanced_histVector = imageHist(output);
plot(enhanced_histVector);
title("Enhanced HistVector");
xlim([0,255]);