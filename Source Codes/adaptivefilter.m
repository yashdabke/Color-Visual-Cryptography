clc;clear;close all;

image = imread('XORED.png');

figure;
sgtitle('Adaptive Local Noise Filtering');

PSF = fspecial('gaussian', [5 5], 1);
gimage = imfilter(image, PSF, 'conv', 'circular');
gimage = imsharpen(gimage,'Radius',2,'Amount',0.4);

if size(image, 3) == 1
    fred = filterImage(gimage);
    combined_rgb_image = fred;
    imwrite(fred,'RECOVERED.png');
else
   red = gimage(:,:,1);
   green = gimage(:,:,2);
   blue = gimage(:,:,3);

   fred = filterImage(red);
   fgreen = filterImage(green);
   fblue = filterImage(blue);

   combined_rgb_image = cat(3, fred, fgreen, fblue);
   imwrite(combined_rgb_image, 'RECOVERED.png');
end

subplot(1,2,1);
imshow(image);
title('Recovered Secret Image ( XORed )');

subplot(1,2,2);
imshow(combined_rgb_image);
title('Recovered Secret Image ( Filtered )');


function filteredImage = filterImage(inputImage)
    M = 3;
    N = 3;
    B = double(inputImage);
    sz = size(B, 1) * size(B, 2);
    C = padarray(B, [floor(M / 2), floor(N / 2)]);
    lvar = zeros([size(B, 1), size(B, 2)]);
    lmean = zeros([size(B, 1), size(B, 2)]);

    for i = 1:size(C, 1) - (M - 1)
        for j = 1:size(C, 2) - (N - 1)
            temp = C(i:i + (M - 1), j:j + (N - 1));
            tmp = temp(:);
            lmean(i, j) = mean(tmp);
            lvar(i, j) = mean(tmp.^2) - mean(tmp).^2;
        end
    end

    nvar = sum(lvar(:)) / sz;
    lvar = max(lvar, nvar);
    NewImg = nvar ./ lvar;
    NewImg = NewImg .* (B - lmean);
    NewImg = B - NewImg;
    filteredImage = uint8(NewImg);
end
