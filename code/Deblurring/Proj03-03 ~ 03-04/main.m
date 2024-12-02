%% Section 1 - Spatial Filtering
clearvars, clc
originalImage = './Fig0338(a).tif';
img = imread(originalImage);
% rows_and_cols = input("Please enter the desired mask rows and cols(e.g. [2, 2]):");
% values = input("Please enter the desired values in the mask(e.g. [1,2,3,4]):");
rows_and_cols = [3,3];
values = [0,1,0,1,-4,1,0,1,0];
mask = reshape(values, [rows_and_cols(1), rows_and_cols(2)]);
output = spatialFiltering(img, mask);

imshow(output, (0:1));
colorbar;

%% Section 2 - Laplacian Filtering
clearvars, clc
originalImage = './Fig0338(a).tif';
img = imread(originalImage);
% rows_and_cols = input("Please enter the desired mask rows and cols(e.g. [2, 2]):");
% values = input("Please enter the desired values in the mask(e.g. [1,2,3,4]):");
rows_and_cols = [3,3];
values = [0,1,0,1,-4,1,0,1,0];
laplacianMask = reshape(values, [rows_and_cols(1), rows_and_cols(2)]);
scale = -1;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);

imshow(output, (0:1));
colorbar;

%% Section 3 - Laplacian Filtering with 4/e Fig. 3.46 (a,b,c,d)
clearvars, clc
originalImage = './Fig0338(a).tif';
img = imread(originalImage);
img = single(img) ./ 255;

figure(1);
tiledlayout(2,2);

nexttile
imshow(img, [0 1]);
title("Original Image (a)");
colorbar

nexttile
laplacianMask = [0,1,0; 1,-4,1; 0,1,0];
transformed_img = spatialFiltering(img, laplacianMask);
imshow(transformed_img, [0 1]);
title("spatial filtering with Laplacian (b)");
colorbar

nexttile
scale = -1;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image (c)");
colorbar

nexttile
laplacianMask = [1,1,1; 1,-8,1; 1,1,1];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image (d)");
colorbar

%% Section 4 - Comparison of different scale 
clearvars, clc
originalImage = './Fig0338(a).tif';
img = imread(originalImage);
img = single(img) ./ 255;

figure(1);
tiledlayout(2,2);

nexttile
laplacianMask = [1,1,1; 1,-8,1; 1,1,1];
imshow(img);
title("Original Image");
colorbar

nexttile
scale = 2;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Imagec, c = 2");
colorbar

nexttile
scale = 4;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Imagec, c = 4");
colorbar

nexttile
scale = 8;
laplacianMask = [1,1,1; 1,-8,1; 1,1,1];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Imagec, c = 8");
colorbar

figure(2);
tiledlayout(2,2);

nexttile
laplacianMask = [1,1,1; 1,-8,1; 1,1,1];
imshow(img);
title("Original Image");
colorbar

nexttile
scale = -2;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Imagec, c = -2");
colorbar

nexttile
scale = -4;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Imagec, c = -4");
colorbar

nexttile
scale = -8;
laplacianMask = [1,1,1; 1,-8,1; 1,1,1];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Imagec, c = -8");
colorbar

%% Section 5 - Comparison of different size
clearvars, clc
originalImage = './Fig0338(a).tif';
img = imread(originalImage);
img = single(img) ./ 255;

% Laplacian mask of size 3 x 3
figure(1);
tiledlayout(1,2);

nexttile
scale = -1;
laplacianMask = [ 0,  1,  0;  1, -4,  1;  0,  1,  0 ];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, mask size: 3x3");
colorbar

nexttile
scale = -1;
laplacianMask = [ 1,  1,  1;  1, -8,  1;  1,  1,  1 ];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, mask size: 3x3");
colorbar

% Laplacian mask of size 5 x 5
figure(2);
tiledlayout(1,2);

nexttile
scale = -1;
laplacianMask = [ 0,  0, -1,  0,  0;  0, -1, -2, -1,  0; -1, -2, 16, -2, -1;  0, -1, -2, -1,  0;  0,  0, -1,  0,  0 ];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, mask size: 5x5");
colorbar

nexttile
scale = -1;
laplacianMask = [ -1, -1, -1, -1, -1;  -1,  2,  2,  2, -1;  -1,  2,  8,  2, -1;  -1,  2,  2,  2, -1;  -1, -1, -1, -1, -1 ];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, mask size: 5x5");
colorbar

% Laplacian mask of size 7 x 7
figure(3);
tiledlayout(1,2);

nexttile
scale = -1;
laplacianMask = [ 0,  0,  0, -1,  0,  0,  0;  0,  0, -1, -2, -1,  0,  0;  0, -1, -2, -4, -2, -1,  0; -1, -2, -4, 28, -4, -2, -1;  0, -1, -2, -4, -2, -1,  0;  0,  0, -1, -2, -1,  0,  0;  0,  0,  0, -1,  0,  0,  0 ];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, mask size: 7x7");
colorbar

nexttile
scale = -1;
laplacianMask = [  0,  0, -1, -1, -1,  0,  0;   0, -1, -2, -2, -2, -1,  0;  -1, -2, -4, -5, -4, -2, -1;  -1, -2, -5, 64, -5, -2, -1;  -1, -2, -4, -5, -4, -2, -1;   0, -1, -2, -2, -2, -1,  0;   0,  0, -1, -1, -1,  0,  0 ];
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, mask size: 7x7");
colorbar

%% Section 6 - Comparison of different method for border padding
clearvars, clc
% originalImage = './Fig0338(a).tif';
originalImage = './Fig220(a).tif';
img = imread(originalImage);
img = single(img) ./ 255;

figure(1);
tiledlayout(1,2);

nexttile
laplacianMask = [1,1,1; 1,-8,1; 1,1,1];
imshow(img);
title("Original Image");
colorbar

nexttile
scale = -1;
[output, scaledLaplacian] = laplacianFiltering(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, padding method = replicate");
colorbar

figure(2);
tiledlayout(1,2);

nexttile
scale = -1;
[output, scaledLaplacian] = laplacianFiltering_circular(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, padding method = circular");
colorbar

nexttile
scale = -1;
[output, scaledLaplacian] = laplacianFiltering_symmetric(img, laplacianMask, scale);
imshow(output);
title("Laplacian Enhanced Image, padding method = symmetric");
colorbar