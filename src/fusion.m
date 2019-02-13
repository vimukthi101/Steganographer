%initialize
clc;
clear variables;
[dir_input, dir_output, dir_results, carrier_image_filename, output_image_filename, secret_msg_str, channel] = steganography_init();

%@@ Alpha value for encoding
alpha = 0.05;

%@@ Wavelet transformation
mode = 'db1';

% Load image, generate message if necessary
im = imload([dir_input, carrier_image_filename]);
[w h ~] = size(im);
msg_length_max = w / 2 * h / 2; % One bit per pixel, in one quarter
msg_length_max = msg_length_max / 8; % Convert to bytes
secret_msg_bin = str2bin(secret_msg_str);

imc = im(:,:,channel);

tic;
[imc_stego, im_wavelet_original, im_wavelet_stego] = steg_fusion_encode(imc, secret_msg_bin, alpha, mode);
encode_time = toc;

im_stego = im;
im_stego(:,:,channel) = imc_stego;

imwrite(uint8(im_stego), [dir_output, output_image_filename], 'quality', 100);

im_stego = imload([dir_output, output_image_filename]);
im_original = imload([dir_input, carrier_image_filename]);

imc_stego = im_stego(:,:,channel);
imc_original = im_original(:,:,channel);

% Verify and compare difference
difference = (imc - imc_stego) .^ 2;

% Print statistics
[im_mse, im_psnr, ssimval, ssimmap, cc] = steganography_statistics(imc, imc_stego, encode_time);

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