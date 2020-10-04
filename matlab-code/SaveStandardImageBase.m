function [standard_image_base] = SaveStandardImageBase()

%Save the 15 standard images into standard_image_base.
standard_image_base = zeros(256,256,15);

image = imread('../input-images/images1.gif');
standard_image_base(:,:,1) = image(:,:);

image = imread('../input-images/images2.gif');
standard_image_base(:,:,2) = image(:,:);

image = imread('../input-images/images3.gif');
standard_image_base(:,:,3) = image(:,:);

image = imread('../input-images/images4.gif');
standard_image_base(:,:,4) = image(:,:);

image = imread('../input-images/images5.gif');
standard_image_base(:,:,5) = image(:,:);

image = imread('../input-images/images6.gif');
standard_image_base(:,:,6) = image(:,:);

image = imread('../input-images/images7.gif');
standard_image_base(:,:,7) = image(:,:);

image = imread('../input-images/images8.gif');
standard_image_base(:,:,8) = image(:,:);

image = imread('../input-images/images9.gif');
standard_image_base(:,:,9) = image(:,:);

image = imread('../input-images/images10.gif');
standard_image_base(:,:,10) = image(:,:);

image = imread('../input-images/images11.gif');
standard_image_base(:,:,11) = image(:,:);

image = imread('../input-images/images12.gif');
standard_image_base(:,:,12) = image(:,:);

image = imread('../input-images/images13.gif');
standard_image_base(:,:,13) = image(:,:);

image = imread('../input-images/images14.gif');
standard_image_base(:,:,14) = image(:,:);

image = imread('../input-images/images15.gif');
standard_image_base(:,:,15) = image(:,:);

end