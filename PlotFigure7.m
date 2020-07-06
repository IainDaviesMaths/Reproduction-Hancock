%Plot Figure 7

%Save the full text into a database
text_image_base=SaveTextImageBase();

%Dimensions of full text
[dim_x, dim_y, ~]=size(text_image_base);

%Largest scale
%Simulation parameters
side_pixels=96;
num_units=8;


%Extract mean grey level from the 1000 samples.
greylevel=0;
for I=1:1000
    %Select piece of image from database.
    image_x=randi(dim_x+1-side_pixels);
    image_y=randi(dim_y+1-side_pixels);    
    image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
    %Find average grey level.
    greylevel=greylevel+sum(sum(image/(side_pixels^2)))/1000;
end

%Initialise weights so that the sum of the squares is approximately 1.
weights=0.06*(rand(num_units,side_pixels^2)-0.5);

learn_rate=1;
for time=1:120000
    %Select 64x64 piece of image from database.
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

%Plot principal components with example text before
finalimage=zeros(side_pixels,side_pixels*9);
image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
finalimage(1:side_pixels,1:side_pixels)=mat2gray(image);
for horiz=2:9
    PC=zeros(side_pixels,side_pixels);
    for I=1:side_pixels
        PC(:,I)=weights(horiz-1,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC=(PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels)=PC;
end

subplot(3,1,1); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])




%Middle scale
%Simulation parameters
side_pixels=48;
num_units=8;

%Extract mean grey level from the 1000 samples.
greylevel=0;
for I=1:1000
    %Select piece of image from database.
    image_x=randi(dim_x+1-side_pixels);
    image_y=randi(dim_y+1-side_pixels);       
    image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
    %Find average grey level.
    greylevel=greylevel+sum(sum(image/(side_pixels^2)))/1000;
end

%Initialise weights so that the sum of the squares is approximately 1.
weights=0.06*(rand(num_units,side_pixels^2)-0.5);

learn_rate=1;
for time=1:120000
    %Select 64x64 piece of image from database.
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

%Plot principal components
finalimage=zeros(side_pixels,side_pixels*9);
image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
finalimage(1:side_pixels,1:side_pixels)=mat2gray(image);
for horiz=2:9
    PC=zeros(side_pixels,side_pixels);
    for I=1:side_pixels
        PC(:,I)=weights(horiz-1,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC=(PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels)=PC;
end

subplot(3,1,2); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])




%Smallest scale
%Simulation parameters
side_pixels=24;
num_units=8;

%Extract mean grey level from the 1000 samples.
greylevel=0;
for I=1:1000
    %Select piece of image from database.
    image_x=randi(dim_x+1-side_pixels);
    image_y=randi(dim_y+1-side_pixels);   
    image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
    %Find average grey level.
    greylevel=greylevel+sum(sum(image/(side_pixels^2)))/1000;
end

%Initialise weights so that the sum of the squares is approximately 1.
weights=0.06*(rand(num_units,side_pixels^2)-0.5);

learn_rate=1;
for time=1:120000
    %Select 64x64 piece of image from database.
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

%Plot principal components
finalimage=zeros(side_pixels,side_pixels*9);
image=text_image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,1);
finalimage(1:side_pixels,1:side_pixels)=mat2gray(image);
for horiz=2:9
    PC=zeros(side_pixels,side_pixels);
    for I=1:side_pixels
        PC(:,I)=weights(horiz-1,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC=(PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels)=PC;
end

subplot(3,1,3); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])

saveas(gcf,'Figure7.png')