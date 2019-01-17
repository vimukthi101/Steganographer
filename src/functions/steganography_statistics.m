function [im_psnr, ssimval, ssimmap, cc] = steganography_statistics(imc, imc_stego, encode_time)

% Calculate PSNR
im_psnr = PSNR(imc, imc_stego);

%calculate SSIM
[ssimval, ssimmap] = SSIM(imc, imc_stego);

%calculate NC
cc = CC(imc, imc_stego);

% ---=== Show statistics ===---

fprintf('Encode time: %fs\n', encode_time);

% PSNR of input image to output image
fprintf('PSNR: %f\n', im_psnr);

% SSSIM of input image to output image
fprintf('SSIM: %f\n', ssimval);

% NC of input image to output image
fprintf('CC: %f\n', cc);

end