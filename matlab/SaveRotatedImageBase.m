function [standard_image_base]=SaveRotatedImageBase()

%Save the 15 standard images into standard_image_base.
standard_image_base=zeros(256,256,15);

image=imrotate(imread('images1.gif'),45,'crop');
standard_image_base(:,:,1)=image(:,:);

image=imrotate(imread('images2.gif'),45,'crop');
standard_image_base(:,:,2)=image(:,:);

image=imrotate(imread('images3.gif'),45,'crop');
standard_image_base(:,:,3)=image(:,:);

image=imrotate(imread('images4.gif'),45,'crop');
standard_image_base(:,:,4)=image(:,:);

image=imrotate(imread('images5.gif'),45,'crop');
standard_image_base(:,:,5)=image(:,:);

image=imrotate(imread('images6.gif'),45,'crop');
standard_image_base(:,:,6)=image(:,:);

image=imrotate(imread('images7.gif'),45,'crop');
standard_image_base(:,:,7)=image(:,:);

image=imrotate(imread('images8.gif'),45,'crop');
standard_image_base(:,:,8)=image(:,:);

image=imrotate(imread('images9.gif'),45,'crop');
standard_image_base(:,:,9)=image(:,:);

image=imrotate(imread('images10.gif'),45,'crop');
standard_image_base(:,:,10)=image(:,:);

image=imrotate(imread('images11.gif'),45,'crop');
standard_image_base(:,:,11)=image(:,:);

image=imrotate(imread('images12.gif'),45,'crop');
standard_image_base(:,:,12)=image(:,:);

image=imrotate(imread('images13.gif'),45,'crop');
standard_image_base(:,:,13)=image(:,:);

image=imrotate(imread('images14.gif'),45,'crop');
standard_image_base(:,:,14)=image(:,:);

image=imrotate(imread('images15.gif'),45,'crop');
standard_image_base(:,:,15)=image(:,:);

end