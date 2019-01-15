function im = imload(filename)
% imload() Loads image, converts to double and optionally to greyscale
% INPUTS
%   filename  - File to open e.g. 'C:\img.png'
%   greyscale - true/false Whether to convert to greyscale

im = imread(filename);
im = double(im);

end

