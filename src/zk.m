%initialize
clc;
clear variables;
[dir_input, dir_output, dir_results, carrier_image_filename, output_image_filename, secret_msg_str, channel] = steganography_init();

test_name = ['ZK_', carrier_image_filename];

%@@ Output image quality
output_quality = 100;

%@@ Coefficients
frequency_coefficients = [4 6; 5 2; 6 5];

% Load image, generate message if necessary
im = imload([dir_input, carrier_image_filename]);
[w h ~] = size(im);
% NOTE: By definition the ZK implementation skips some blocks, so the below
% calculation for msg_length_max is a best case estimation.
msg_length_max = w / 8 * h / 8; % One bit per 8x8
msg_length_max = msg_length_max / 8; % Convert to bytes
secret_msg_bin = str2bin(secret_msg_str);

imc = im(:,:,channel);

% Perform encoding
variance_threshold = 1; % Higher = more blocks used
minimum_distance_encode = 200; % Higher = more robust; more visible
minimum_distance_decode = 10;

tic;
[imc_stego, bits_written, bits_unused, invalid_blocks_encode, debug_invalid_encode] = steg_zk_encode(secret_msg_bin, imc, frequency_coefficients, variance_threshold, minimum_distance_encode);
encode_time = toc;

im_stego = im;
im_stego(:,:,channel) = imc_stego;

% Write to file
imwrite(uint8(im_stego), [dir_output, output_image_filename], 'Quality', output_quality);

im_stego = imload([dir_output, output_image_filename]);

imc_stego = im_stego(:,:,channel);

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