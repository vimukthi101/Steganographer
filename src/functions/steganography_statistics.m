function [im_psnr] = steganography_statistics(imc, imc_stego, encode_time)

% Calculate PSNR
im_psnr = PSNR(imc, imc_stego);

% ---=== Show statistics ===---

fprintf('Encode time: %fs\n', encode_time);

% PSNR of input image to output image
fprintf('PSNR: %f\n', im_psnr);

end