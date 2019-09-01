function [text_image_base]=SaveTextImageBase()

%Save the text image.

image=rgb2gray(imread('textimage.png'));
text_image_base(:,:,1)=double(image(:,:));

end