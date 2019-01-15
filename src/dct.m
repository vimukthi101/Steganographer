%initialize
clc;
clear variables;
[dir_input, dir_output, dir_results, carrier_image_filename, output_image_filename, secret_msg_str, channel] = steganography_init();

%@@ Coefficients
frequency_coefficients = [3 6; 5 2];

% Load image
im = imload([dir_input, carrier_image_filename]);

%%%im = rgb2hsv(im);

[w h ~] = size(im);
msg_length_max = w / 8 * h / 8; % One bit per 8x8
msg_length_max = msg_length_max / 8; % Convert to bytes
secret_msg_bin = str2bin(secret_msg_str);
secret_msg_bin_raw = secret_msg_bin;

% Take chosen channel from the image and encode
imc = im(:,:,channel);

tic;
[imc_stego, bits_written, bits_unused] = steg_dct_encode(secret_msg_bin_raw, imc, frequency_coefficients, 100);
encode_time = toc;

% Put the channels back together, and write
im_stego = im;
im_stego(:,:,channel) = imc_stego;

%%%im_stego = hsv2rgb(im_stego);

imwrite(uint8(im_stego), [dir_output, output_image_filename], 'Quality', 100);

% Read image and take chosen channel
im_stego = imload([dir_output, output_image_filename]);

%%%im_stego = rgb2hsv(im_stego);

imc_stego = im_stego(:,:,channel);

% Verify and compare difference
difference = (imc - imc_stego) .^ 2;

% Display images
subplot(1,3,1);
imshow(uint8(im));
title('Carrier');
subplot(1,3,2);
imshow(uint8(im_stego));
title('Stego image');
subplot(1,3,3);
imshow(difference);
title('Difference');

% Print statistics
[im_psnr] = steganography_statistics(imc, imc_stego, encode_time);