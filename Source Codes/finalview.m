clc;clear;close all;

[filename, filepath] = uigetfile({'*.jpg;*.png;*.bmp;*.tif', 'Image Files (*.jpg, *.png, *.bmp, *.tif)'; '*.*', 'All Files (*.*)'}, 'Select an image');
if isequal(filename, 0)
    fprintf('User canceled the file selection. Exiting.\n');
    return;
end

figure;
sgtitle('Comparison of Visual Cryptography Images ( with Color Distribution )');

Image = imread(fullfile(filepath, filename));
Output1 = imread('XORED.png');
Output2 = imread('RECOVERED.png');
Output3 = imread('Share1.png');

if(size(Image, 3) == 1)
    hist1 = imhist(Image);
    hist2 = imhist(Output1);
    hist3 = imhist(Output2);
    hist4 = imhist(Output3);

    subplot(2,4,1);
    imshow(Image);title('Original Secret Image');

    subplot(2,4,2);
    imshow(im2gray(Output3));title('Share Image');

    subplot(2,4,3);
    imshow(Output1);title('Recovered Secret Image ( Unfiltered )');

    subplot(2,4,4);
    imshow(Output2);title('Recovered Secret Image ( Filtered )');
    
    subplot(2,4,5);
    plot(hist1,'LineWidth', 2);
    xlabel('Pixel Value (Intensity)');
    ylabel('Frequency');
    grid on; 
    grid minor;
    xticks(0:51:255);
    xlim('padded'); 
    
    subplot(2,4,6);
    plot(hist2,'LineWidth', 2);
    xlabel('Pixel Value (Intensity)');
    ylabel('Frequency');
    grid on; 
    grid minor;
    xticks(0:51:255);
    xlim('padded');

    subplot(2,4,7);
    plot(hist4,'LineWidth', 2);
    xlabel('Pixel Value (Intensity)');
    ylabel('Frequency');
    grid on; 
    grid minor;
    xticks(0:51:255);
    xlim('padded');

    subplot(2,4,8);
    plot(hist3,'LineWidth', 2);
    xlabel('Pixel Value (Intensity)');
    ylabel('Frequency');
    grid on; 
    grid minor;
    xticks(0:51:255);
    xlim('padded');
else

red1 = Image(:,:,1);
green1 = Image(:,:,2);
blue1 = Image(:,:,3);

red2 = Output1(:,:,1);
green2 = Output1(:,:,2);
blue2 = Output1(:,:,3);

red3 = Output2(:,:,1);
green3 = Output2(:,:,2);
blue3 = Output2(:,:,3);

red4 = Output3(:,:,1);
green4 = Output3(:,:,2);
blue4 = Output3(:,:,3);

red_hist1 = imhist(red1);
green_hist1 = imhist(green1);
blue_hist1 = imhist(blue1);

red_hist2 = imhist(red2);
green_hist2 = imhist(green2);
blue_hist2 = imhist(blue2);

red_hist3 = imhist(red3);
green_hist3 = imhist(green3);
blue_hist3 = imhist(blue3);

red_hist4 = imhist(red4);
green_hist4 = imhist(green4);
blue_hist4 = imhist(blue4);


subplot(2,4,1);
imshow(Image);title('Original Secret Image');

subplot(2,4,2);
imshow(Output3);title('Share Image');

subplot(2,4,3);
imshow(Output1);title('Recovered Secret Image ( Unfiltered )');

subplot(2,4,4);
imshow(Output2);title('Recovered Secret Image ( Filtered )');

subplot(2, 4, 5);
plot(red_hist1, 'r', 'LineWidth', 2);
hold on;
plot(green_hist1, 'g', 'LineWidth', 2);
plot(blue_hist1, 'b', 'LineWidth', 2);
hold off;
xlabel('Pixel Value (Intensity)');
ylabel('Frequency')
grid on; 
grid minor;
xticks(0:51:255);
xlim('padded'); 

subplot(2, 4, 6);
plot(red_hist4, 'r', 'LineWidth', 2);
hold on;
plot(green_hist4, 'g', 'LineWidth', 2);
plot(blue_hist4, 'b', 'LineWidth', 2);
hold off;
xlabel('Pixel Value (Intensity)');
ylabel('Frequency')
grid on; 
grid minor;
xticks(0:51:255);
xlim('padded'); 


subplot(2, 4, 7);
plot(red_hist2, 'r', 'LineWidth', 2);
hold on;
plot(green_hist2, 'g', 'LineWidth', 2);
plot(blue_hist2, 'b', 'LineWidth', 2);
hold off;
xlabel('Pixel Value (Intensity)');
ylabel('Frequency')
grid on; 
grid minor;
xticks(0:51:255);
xlim('padded'); 
 

subplot(2, 4, 8);
plot(red_hist3, 'r', 'LineWidth', 2);
hold on;
plot(green_hist3, 'g', 'LineWidth', 2);
plot(blue_hist3, 'b', 'LineWidth', 2);
hold off;
xlabel('Pixel Value (Intensity)');
ylabel('Frequency')
grid on; 
grid minor;
xticks(0:51:255);
xlim('padded'); 
end