clc;clear;close all;

red = imread('red.png');
green = imread('green.png');
blue = imread('blue.png');

figure;
sgtitle('Floyd - Steinberg Dithering');

if isequal(red, green) && isequal(green, blue)
    dred = applyFloydSteinbergDithering(red);

    subplot(1,2,1);
    imshow(red);title('Grayscale Image');
    subplot(1,2,2);
    imshow(dred);title('Dithered Image');

    imwrite(dred,'d_red.png');
    imwrite(dred,'d_green.png');
    imwrite(dred,'d_blue.png');
else
    dred = applyFloydSteinbergDithering(red);
    dgreen = applyFloydSteinbergDithering(green);
    dblue = applyFloydSteinbergDithering(blue);
    outputImage = cat(3,dred,dgreen,dblue);

    subplot(2,3,1);
    imshow(dred);title('Red Dithered');
    subplot(2,3,2);
    imshow(dgreen);title('Green Dithered');
    subplot(2,3,3);
    imshow(dblue);title('Blue Dithered');
    subplot(2,1,2);
    imshow(cat(3,dred,dgreen,dblue));title('Dithered Image');

    imwrite(dred,'d_red.png');
    imwrite(dgreen,'d_green.png');
    imwrite(dblue,'d_blue.png');
end

function ditheredImage = applyFloydSteinbergDithering(inputChannel)
    inputImage = double(inputChannel);
    [height, width] = size(inputImage);
    outputImage = zeros(height, width);

    for y = 1:height
        for x = 1:width
            oldPixel = inputImage(y, x);
            newPixel = 255 * (oldPixel > 127);
            error = oldPixel - newPixel;

            outputImage(y, x) = newPixel;

            if x < width
                inputImage(y, x + 1) = inputImage(y, x + 1) + error * 7 / 16;
            end
            if x > 1 && y < height
                inputImage(y + 1, x - 1) = inputImage(y + 1, x - 1) + error * 3 / 16;
            end
            if y < height
                inputImage(y + 1, x) = inputImage(y + 1, x) + error * 5 / 16;
            end
            if x < width && y < height
                inputImage(y + 1, x + 1) = inputImage(y + 1, x + 1) + error * 1 / 16;
            end
        end
    end

    ditheredImage = uint8(outputImage);
end