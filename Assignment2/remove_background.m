function image = remove_background(image)

background = image < 20; % or whatever number works
image(background) = 0; % Set background to 0 (black).
% imshow(image)
end