function [ssimval, ssimmap] = SSIM(a, b)
% SSIM() Structural similarity index
% INPUTS
%    a - Image 1
%    b - Image 2 (same size as 1)
% OUTPUTS
%    ssim - Resulting ssim between a and b

[ssimval, ssimmap] = ssim(a,b);

end