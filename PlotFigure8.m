%Plot Figure 8

%Save the full text into a database
text_image_base=SaveTextImageBase();

%Dimensions of full text
[dim_x, dim_y, ~]=size(text_image_base);

%Simulation parameters
side_pixels=96;
num_units=15;


%Extract mean grey level from 5000 samples.
greylevel=0;
for I=1:5000
    %Select piece of image from database.
    image_x=randi(dim_x+1-side_pixels);
    image_y=randi(dim_y+1-side_pixels);    
    image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
    %Find average grey level.
    greylevel=greylevel+sum(sum(image/(side_pixels^2)))/5000;
end

%Initialise weights so that the sum of the squares is approximately 1.
weights=0.06*(rand(num_units,side_pixels^2)-0.5);

learn_rate=1;
for time=1:120000
    %Select piece of image from database.
    image_x=randi(dim_x+1-side_pixels);
    image_y=randi(dim_y+1-side_pixels);   
    image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
    %Subtract mean grey level
    image=image-greylevel;
    %Mask the image with a Gaussian.
    image=image.*Gaussian(side_pixels);
    %Reshape image matrix into a vector.
    image_vec=reshape(image,side_pixels^2,1);
    %Normalise the image vector to have unit length.
    image_vec=image_vec/norm(image_vec);
    %Update weights.
    weights=sagerupdate( image_vec, weights, learn_rate );
    
    %Change learning rate every 20000 presentations.
    if mod(time,20000)==0
        learn_rate=learn_rate/2;
    end
end

%Save full image
full_image=text_image_base(:,:,1);

%Extract filter which corresponds to spaces between words.
filter=zeros(side_pixels,side_pixels);
for I=1:side_pixels
    filter(:,I)=weights(5,(I-1)*side_pixels+1:I*side_pixels);
end
filter=(filter-min(min(filter)))/(max(max(filter))-min(min(filter)));

%Convolve full image with filter and take its compliment.
convolution=conv2(full_image,filter,'same');
comp=imcomplement(mat2gray(convolution));
%Superimpose this onto the full image.
superimp=(mat2gray(full_image)+(im2bw(comp,0.045)));

figure(1)
subplot(1,3,1); imshow(mat2gray(full_image)); title('Text Image')
subplot(1,3,2); imshow(mat2gray(comp.^0.4)); title('Convolution')
subplot(1,3,3); imshow(mat2gray(superimp)); title('Superimposition')

saveas(gcf,'Figure8.png')
