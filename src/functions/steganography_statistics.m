function [im_mse, im_psnr, ssimval, ssimmap, cc] = steganography_statistics(imc, imc_stego, encode_time)

% Calculate MSE
im_mse = immse(imc_stego, imc);

% Calculate PSNR
im_psnr = psnr(imc_stego, imc);

%calculate SSIM
[ssimval, ssimmap] = ssim(imc_stego, imc);

%calculate NC
cc = corr2(imc_stego, imc);

% ---=== Show statistics ===---

fprintf('Encode time: %fs\n', encode_time);

% MSE of output image to input image
fprintf('MSE: %f\n', im_mse);

% PSNR of output image to input image
fprintf('PSNR: %f\n', im_psnr);

% SSSIM of output image to input image
fprintf('SSIM: %f\n', ssimval);

% NC of output image to input image
fprintf('CC: %f\n', cc);

end