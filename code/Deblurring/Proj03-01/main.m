%% Section 1 - Log transform
clearvars, clc
originalImage = './Fig0308(a).tif';
img = imread(originalImage);
c = input("Please enter the desired scalingFactor c:");
transformedImg = logTransform(img, c);
imshow(transformedImg)
title(sprintf("Scaling factor: %.3f", c));
colorbar


%% Section 2 - Power law transform
clearvars, clc
originalImage = './Fig0308(a).tif';
img = imread(originalImage);
c = input("Please enter the desired scalingFactor c:");
r = input("Please enter the desired gamma value: ");
transformedImg = powerlawTransform(img, c, r);
imshow(transformedImg)
title(sprintf("Scaling factor: %.3f", c));
colorbar

%% Section 3 - Proj03_01 Submission
clearvars, clc
originalImage = './Fig0308(a).tif';
img = imread(originalImage);
figure(1);
tiledlayout(1, 2);

% c = input("Please enter the desired scalingFactor c:");
c = 30;
% r1 = input("Please enter the desired gamma value r1: ");
r1 = 1.0;
% r2 = input("Please enter the desired gamma value r2: ");
r2 = 0.8;
% r3 = input("Please enter the desired gamma value r3: ");
r3 = 0.6;
% r4 = input("Please enter the desired gamma value r4: ");
r4 = 0.4;
% r5 = input("Please enter the desired gamma value r5: ");
r5 = 0.2;

nexttile
transformedImg = logTransform(img, c);
imshow(transformedImg)
title(sprintf("LogTransform c=%.2f", c));
colorbar

nexttile
transformedImg = powerlawTransform(img, c, r1);
imshow(transformedImg)
title(sprintf("PowerLawTransform c=%d, gamma=%.2f", c, r1));
colorbar

figure(2);
tiledlayout(1,2);

nexttile
transformedImg = powerlawTransform(img, c, r2);
imshow(transformedImg)
title(sprintf("PowerLawTransform c=%d, gamma=%.2f", c, r2));
colorbar

nexttile
transformedImg = powerlawTransform(img, c, r3);
imshow(transformedImg)
title(sprintf("PowerLawTransform c=%d, gamma=%.2f", c, r3));
colorbar

figure(3);
tiledlayout(1,2);

nexttile
transformedImg = powerlawTransform(img, c, r4);
imshow(transformedImg)
title(sprintf("PowerLawTransform c=%d, gamma=%.2f", c, r4));
colorbar

nexttile
transformedImg = powerlawTransform(img, c, r5);
imshow(transformedImg)
title(sprintf("PowerLawTransform c=%d, gamma=%.2f", c, r5));
colorbar

%% Section 4 - Original Image
clearvars, clc
originalImage = './Fig0308(a).tif';
img = imread(originalImage);
imshow(img);
title("Original image");
colorbar