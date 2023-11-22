clc; clear; close all;

[filename, filepath] = uigetfile({'*.jpg;*.png;*.bmp;*.tif', 'Image Files (*.jpg, *.png, *.bmp, *.tif)'; '*.*', 'All Files (*.*)'}, 'Select an image');
if isequal(filename, 0)
    fprintf('User canceled the file selection. Exiting.\n');
    return;
end

rgbImage1 = imread(fullfile(filepath, filename));
rgbImage2 = imread('RECOVERED.png'); 

if size(rgbImage1, 3) == 1
    originalImage = rgbImage1;
    distortedImage = rgbImage2;
    originalImage = im2gray(originalImage);
    distortedImage = im2gray(distortedImage);
else
   originalImage = rgb2ycbcr(rgbImage1);
   originalImage = originalImage(:,:,1);
   distortedImage = rgb2ycbcr(rgbImage2);
   distortedImage = distortedImage(:,:,1);
end

squared_diff = (double(originalImage) - double(distortedImage)).^2;
mse = sum(squared_diff(:)) / (numel(double(originalImage)));
psnr = 10 * log10((255^2) / mse);
md = max(abs(double(originalImage(:)) - double(distortedImage(:))));
nae = sqrt(mse) / md;
ssimValue = ssim(distortedImage, originalImage);

figure;
axis off;
sgtitle('Image Quality Metrics');
text(0.1, 0.9, sprintf('MSE: %.3f', mse),'FontSize',16);
text(0.1, 0.8, sprintf('PSNR: %.3f dB', psnr),'FontSize',16);
text(0.1, 0.7, sprintf('MD: %.3f', md),'FontSize',16);
text(0.1, 0.6, sprintf('NAE: %.3f', nae),'FontSize',16);
text(0.1, 0.5, sprintf('SSIM: %.3f', ssimValue),'FontSize',16);