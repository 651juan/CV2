function image = remove_background(image)
%   Detailed explanation goes here

% mask = zeros(size(image));
% mask(30:end-30, 30:end-30) = 1;

% foreground = activecontour(image, mask, 150);

% image = image .* uint8(foreground);





BW1 = im2bw(image,graythresh(image));

image = uint8(BW1).*image;

end