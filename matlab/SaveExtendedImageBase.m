function [extended_image_base]=SaveExtendedImageBase()

%Save the 15 standard images into standard_image_base.
extended_image_base=zeros(256,256,40);

image=imread('images1.gif');
extended_image_base(:,:,1)=image(:,:);

image=imread('images2.gif');
extended_image_base(:,:,2)=image(:,:);

image=imread('images3.gif');
extended_image_base(:,:,3)=image(:,:);

image=imread('images4.gif');
extended_image_base(:,:,4)=image(:,:);

image=imread('images5.gif');
extended_image_base(:,:,5)=image(:,:);

image=imread('images6.gif');
extended_image_base(:,:,6)=image(:,:);

image=imread('images7.gif');
extended_image_base(:,:,7)=image(:,:);

image=imread('images8.gif');
extended_image_base(:,:,8)=image(:,:);

image=imread('images9.gif');
extended_image_base(:,:,9)=image(:,:);

image=imread('images10.gif');
extended_image_base(:,:,10)=image(:,:);

image=imread('images11.gif');
extended_image_base(:,:,11)=image(:,:);

image=imread('images12.gif');
extended_image_base(:,:,12)=image(:,:);

image=imread('images13.gif');
extended_image_base(:,:,13)=image(:,:);

image=imread('images14.gif');
extended_image_base(:,:,14)=image(:,:);

image=imread('images15.gif');
extended_image_base(:,:,15)=image(:,:);

image=imread('new1.gif');
extended_image_base(:,:,16)=image(:,:);

image=imread('new2.gif');
extended_image_base(:,:,17)=image(:,:);

image=imread('new3.gif');
extended_image_base(:,:,18)=image(:,:);

image=imread('new4.gif');
extended_image_base(:,:,19)=image(:,:);

image=imread('new5.gif');
extended_image_base(:,:,20)=image(:,:);

image=imread('new6.gif');
extended_image_base(:,:,21)=image(:,:);

image=imread('new7.gif');
extended_image_base(:,:,22)=image(:,:);

image=imread('new8.gif');
extended_image_base(:,:,23)=image(:,:);

image=imread('new9.gif');
extended_image_base(:,:,24)=image(:,:);

image=imread('new10.gif');
extended_image_base(:,:,25)=image(:,:);

image=imread('new11.gif');
extended_image_base(:,:,26)=image(:,:);

image=imread('new12.gif');
extended_image_base(:,:,27)=image(:,:);

image=imread('new13.gif');
extended_image_base(:,:,28)=image(:,:);

image=imread('new14.gif');
extended_image_base(:,:,29)=image(:,:);

image=imread('new15.gif');
extended_image_base(:,:,30)=image(:,:);

image=imread('two0.gif');
extended_image_base(:,:,31)=image(:,:);

image=imread('two1.gif');
extended_image_base(:,:,32)=image(:,:);

image=imread('two2.gif');
extended_image_base(:,:,33)=image(:,:);

image=imread('two3.gif');
extended_image_base(:,:,34)=image(:,:);

image=imread('two4.gif');
extended_image_base(:,:,35)=image(:,:);

image=imread('two5.gif');
extended_image_base(:,:,36)=image(:,:);

image=imread('two6.gif');
extended_image_base(:,:,37)=image(:,:);

image=imread('two7.gif');
extended_image_base(:,:,38)=image(:,:);

image=imread('two8.gif');
extended_image_base(:,:,39)=image(:,:);

image=imread('two9.gif');
extended_image_base(:,:,40)=image(:,:);

end