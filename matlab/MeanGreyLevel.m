function [greylevel]=MeanGreyLevel(side_pixels, image_base, num_image)
%MEANGREYLEVEL finds mean grey level of 20000 samples of side_pixel^2
%samples of images.

%Mean grey level
greylevel=0;
for I=1:20000
    %Select piece of image from database.
    image_no=randi(num_image);
    image_x=randi(257-side_pixels);
    image_y=randi(257-side_pixels);
    image=image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,image_no);
    %Find average grey level.
    greylevel=greylevel+sum(sum(image/(side_pixels^2)))/20000;
end

end