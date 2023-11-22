clc;clear;close all;

input_image_paths = {'d_red.png', 'd_green.png', 'd_blue.png'};

n = input('Enter the number of shares to be generated: ');
if n<=1
    fprintf('ERROR , number of shares should be more than 1 ');
    return;
end

subplot_rows = ceil(n / 5); 
subplot_cols = min(n, 5);   

figure;
sgtitle('Generation of Shares');

for i = 1:numel(input_image_paths)
    generate_shares(input_image_paths{i}, n);
end

for i = 1:n

    red_share = imread(['d_red_share', num2str(i), '.png']);
    green_share = imread(['d_green_share', num2str(i), '.png']);
    blue_share = imread(['d_blue_share', num2str(i), '.png']);
    rgb_image = cat(3, red_share, green_share, blue_share);
    imwrite(rgb_image, ['Share', num2str(i), '.png']);

    row = ceil(i / subplot_cols);
    col = mod(i - 1, subplot_cols) + 1;

    subplot(subplot_rows, subplot_cols, i);
    imshow(rgb_image);
    title(['Share ', num2str(i)]);
end

for i = 1:n
    delete(['d_red_share', num2str(i), '.png']);
    delete(['d_green_share', num2str(i), '.png']);
    delete(['d_blue_share', num2str(i), '.png']);
end


function generate_shares(input_image_path, n)

    input_image = imread(input_image_path);
    input_image = imbinarize(input_image);
    original_file_name = strsplit(input_image_path, '/');
    original_file_name = original_file_name{end}; 
    [~, original_file_name_noext, ~] = fileparts(original_file_name);

    share_arrays = cell(1, n);

    for i = 1:size(input_image, 1)
        for j = 1:size(input_image, 2)
            original_pixel = input_image(i, j);
            share_pixels = randi([0, 1], 1, n - 1);
            share_pixels = [share_pixels, bitxor(original_pixel, mod(sum(share_pixels), 2))];

            for k = 1:n
                share_arrays{k}(i, j) = share_pixels(k);
            end
        end
    end

    for k = 1:n
        share_image = uint8(share_arrays{k} * 255);
        imwrite(share_image, sprintf('%s_share%d.png',original_file_name_noext,k), 'png');
    end
    
    fprintf('Shares generated successfully.\n');
end
