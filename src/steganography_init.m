function [dir_input, dir_output, dir_results, carrier_image_filename, output_image_filename, secret_msg_str, channel] = steganography_init()
% steganography_init() Sets up Matlab workspace for steganography functions
dir = 'C:\Users\Vimukthi\Desktop\Steganographer\';
% Ensure correct directory
cd(dir);

% Return input and output directories
dir_input = 'inputs\';
dir_output = 'outputs\';
dir_results = 'results\';

%@@ Input image and output location
carrier_image_filename = 'lena.jpg';
output_image_filename = 'test_zk.jpg';

%@@ Message string to encode into carrier image
secret_msg_str = 'hello world';

%@@ select which colour channel to use (1=r, 2=g, 3=b)
channel = 3;

end
