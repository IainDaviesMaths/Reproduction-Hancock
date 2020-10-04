function [text_image_base] = SaveTextImageBase()

%Save the text images.

%Century Font
image = rgb2gray(imread('../input-images/textimage.png'));
text_image_base(:,:,1) = double(image(:,:));

%Calibri Font
image = rgb2gray(imread('../input-images/textimage2.png'));
text_image_base(:,:,2) = double(image(:,:));

end