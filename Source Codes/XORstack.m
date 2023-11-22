clc;clear;close all;

n = input('Enter the number of shares to XOR: ');
if n<=1
    fprintf('ERROR , number of shares should be more than 1 ');
    return;
end

shares = cell(n, 1);
for i = 1:n
    shares{i} = imread(['share' num2str(i) '.png']);
end

r_xor = shares{1}(:,:,1);
g_xor = shares{1}(:,:,2);
b_xor = shares{1}(:,:,3);

for i = 2:n
    r_share = shares{i}(:,:,1);
    g_share = shares{i}(:,:,2);
    b_share = shares{i}(:,:,3);
    
    r_xor = bitxor(r_xor, r_share);
    g_xor = bitxor(g_xor, g_share);
    b_xor = bitxor(b_xor, b_share);
end

if isequal(r_xor,g_xor) && isequal(g_xor,b_xor)
    output_image = r_xor;
    imwrite(output_image, 'XORED.png');
else
    output_image = cat(3, r_xor, g_xor, b_xor);
    imwrite(output_image, 'XORED.png');
end


figure;
sgtitle('XORing of Shares');

subplot(1,2,1);
imshow(shares{1});
title('Share Image');

subplot(1,2,2);
imshow(output_image);
title('Recovered Secret Image');


