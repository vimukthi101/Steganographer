function cc = CC(a, b)
% CC() 2-D correlation coefficient
% INPUTS
%    a - Image 1
%    b - Image 2 (same size as 1)
% OUTPUTS
%    nc - Resulting 2-D correlation coefficient between a and b
cc = corr2(a,b);
end