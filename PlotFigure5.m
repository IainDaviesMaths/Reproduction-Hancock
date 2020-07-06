%Plot Figure 5

%Generate weights for 15 image case

%Simulation parameters
side_pixels=64;
num_units=15;

%Save the 15 images into a database
num_image=15;
standard_image_base=SaveStandardImageBase();

%Extract mean grey level from 20000 samples.
meangrey=MeanGreyLevel(side_pixels, standard_image_base, num_image);

%Learn weights
weights15=LearningProcess(num_units,side_pixels,standard_image_base,num_image,meangrey);

%Initialise test outputs
outputs15=zeros(10000,15);

%Produce 10000 test outputs
for test=1:10000
    %Select 64x64 piece of image from database.
    image_no=randi(num_image);
    image_x=randi(257-side_pixels);
    image_y=randi(257-side_pixels);
    image=standard_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,image_no);
    %Subtract mean grey level
    image=image-meangrey;
    %Mask the image with a Gaussian.
    image=image.*Gaussian(side_pixels);
    %Reshape image matrix into a vector.
    image_vec=reshape(image,side_pixels^2,1);
    %Normalise the image vector to have unit length.
    image_vec=image_vec/norm(image_vec);
    
    %Find output values
    outputs15(test,:)=(weights15*image_vec)';
end

clf
variance15=var(outputs15);
scatter(1:15,variance15)
set(gca,'xscale','log')
set(gca,'yscale','log')
hold on

%Generate weights for 40 image case

%Simulation parameters
side_pixels=64;
num_units=15;

%Save the 40 images into a database
num_image=40;
extended_image_base=SaveExtendedImageBase();

%Extract mean grey level from 20000 samples.
meangrey=MeanGreyLevel(side_pixels, extended_image_base, num_image);

%Learn weights
weights40=LearningProcess(num_units,side_pixels,extended_image_base,num_image,meangrey);

%Initialise test outputs
outputs40=zeros(10000,15);

%Produce 10000 test outputs
for test=1:10000
    %Select 64x64 piece of image from database.
    image_no=randi(num_image);
    image_x=randi(257-side_pixels);
    image_y=randi(257-side_pixels);
    image=extended_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,image_no);
    %Subtract mean grey level
    image=image-meangrey;
    %Mask the image with a Gaussian.
    image=image.*Gaussian(side_pixels);
    %Reshape image matrix into a vector.
    image_vec=reshape(image,side_pixels^2,1);
    %Normalise the image vector to have unit length.
    image_vec=image_vec/norm(image_vec);
    
    %Find output values
    outputs40(test,:)=(weights40*image_vec)';
end

variance40=var(outputs40);
scatter(1:15,variance40,'x')
xlabel('Component Number')
ylabel('Output Variance')
legend('15 images','40 images')

saveas(gcf,'Figure5.png')