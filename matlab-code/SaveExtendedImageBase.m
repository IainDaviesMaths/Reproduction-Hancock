function [extended_image_base] = SaveExtendedImageBase()

%Save the 15 standard images into standard_image_base.
extended_image_base = zeros(256,256,40);

image = imread('../input-images/images1.gif');
extended_image_base(:,:,1) = image(:,:);

image = imread('../input-images/images2.gif');
extended_image_base(:,:,2) = image(:,:);

image = imread('../input-images/images3.gif');
extended_image_base(:,:,3) = image(:,:);

image = imread('../input-images/images4.gif');
extended_image_base(:,:,4) = image(:,:);

image = imread('../input-images/images5.gif');
extended_image_base(:,:,5) = image(:,:);

image = imread('../input-images/images6.gif');
extended_image_base(:,:,6) = image(:,:);

image = imread('../input-images/images7.gif');
extended_image_base(:,:,7) = image(:,:);

image = imread('../input-images/images8.gif');
extended_image_base(:,:,8) = image(:,:);

image = imread('../input-images/images9.gif');
extended_image_base(:,:,9) = image(:,:);

image = imread('../input-images/images10.gif');
extended_image_base(:,:,10) = image(:,:);

image = imread('../input-images/images11.gif');
extended_image_base(:,:,11) = image(:,:);

image = imread('../input-images/images12.gif');
extended_image_base(:,:,12) = image(:,:);

image = imread('../input-images/images13.gif');
extended_image_base(:,:,13) = image(:,:);

image = imread('../input-images/images14.gif');
extended_image_base(:,:,14) = image(:,:);

image = imread('../input-images/images15.gif');
extended_image_base(:,:,15) = image(:,:);

image = imread('../input-images/new1.gif');
extended_image_base(:,:,16) = image(:,:);

image = imread('../input-images/new2.gif');
extended_image_base(:,:,17) = image(:,:);

image = imread('../input-images/new3.gif');
extended_image_base(:,:,18) = image(:,:);

image = imread('../input-images/new4.gif');
extended_image_base(:,:,19) = image(:,:);

image = imread('../input-images/new5.gif');
extended_image_base(:,:,20) = image(:,:);

image = imread('../input-images/new6.gif');
extended_image_base(:,:,21) = image(:,:);

image = imread('../input-images/new7.gif');
extended_image_base(:,:,22) = image(:,:);

image = imread('../input-images/new8.gif');
extended_image_base(:,:,23) = image(:,:);

image = imread('../input-images/new9.gif');
extended_image_base(:,:,24) = image(:,:);

image = imread('../input-images/new10.gif');
extended_image_base(:,:,25) = image(:,:);

image = imread('../input-images/new11.gif');
extended_image_base(:,:,26) = image(:,:);

image = imread('../input-images/new12.gif');
extended_image_base(:,:,27) = image(:,:);

image = imread('../input-images/new13.gif');
extended_image_base(:,:,28) = image(:,:);

image = imread('../input-images/new14.gif');
extended_image_base(:,:,29) = image(:,:);

image = imread('../input-images/new15.gif');
extended_image_base(:,:,30) = image(:,:);

image = imread('../input-images/two0.gif');
extended_image_base(:,:,31) = image(:,:);

image = imread('../input-images/two1.gif');
extended_image_base(:,:,32) = image(:,:);

image = imread('../input-images/two2.gif');
extended_image_base(:,:,33) = image(:,:);

image = imread('../input-images/two3.gif');
extended_image_base(:,:,34) = image(:,:);

image = imread('../input-images/two4.gif');
extended_image_base(:,:,35) = image(:,:);

image = imread('../input-images/two5.gif');
extended_image_base(:,:,36) = image(:,:);

image = imread('../input-images/two6.gif');
extended_image_base(:,:,37) = image(:,:);

image = imread('../input-images/two7.gif');
extended_image_base(:,:,38) = image(:,:);

image = imread('../input-images/two8.gif');
extended_image_base(:,:,39) = image(:,:);

image = imread('../input-images/two9.gif');
extended_image_base(:,:,40) = image(:,:);

end