%initialize
clc;
clear variables;
[dir_input, dir_output, dir_results, carrier_image_filename, output_image_filename, secret_msg_str, channel] = steganography_init();

%@@ Transform function
mode = 'db1';

%@@ Coefficients
frequency_coefficients = [7 6; 5 2];

% Load image, generate message if necessary
im = imload([dir_input, carrier_image_filename]);
[w h ~] = size(im);
msg_length_max = w / 16 * h / 16; % One bit per 8x8, in one quarter
msg_length_max = ceil(msg_length_max / 8); % Convert to bytes
secret_msg_bin = str2bin(secret_msg_str);

imc = im(:,:,channel);

tic;
[imc_stego, im_wavelet] = steg_wdct_encode(imc, secret_msg_bin, mode, frequency_coefficients, 100);
encode_time = toc;

im_stego = im;
im_stego(:,:,channel) = imc_stego;

% Write
imwrite(uint8(im_stego), [dir_output, output_image_filename], 'Quality', 100);

% Read and take chosen channel
im_stego = imload([dir_output, output_image_filename]);

imc_stego = im_stego(:,:,channel);

% Verify and compare difference
difference = (imc - imc_stego) .^ 2;

% Print statistics
[im_psnr, ssimval, ssimmap, cc] = steganography_statistics(imc, imc_stego, encode_time);

% Display images
subplot(1,4,1);
imshow(uint8(im));
title('Carrier');
subplot(1,4,2);
imshow(uint8(im_stego));
title('Stego image');
subplot(1,4,3);
imshow(difference);
title('Difference of PSNR');
subplot(1,4,4);
imshow(ssimmap);
title('Difference of SSIM');