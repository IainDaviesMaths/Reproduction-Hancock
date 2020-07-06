%Plot Figure 6

%Double scale:

%Simulation parameters
side_pixels=128;
num_units=6;

%Save the 15 images into a database
num_image=15;
standard_image_base=SaveStandardImageBase();

%Extract mean grey level from 20000 samples.
meangrey=MeanGreyLevel(side_pixels, standard_image_base, num_image);

%Learn weights
weights=LearningProcess(num_units,side_pixels,standard_image_base,num_image,meangrey);

%Plot principal components
finalimage=zeros(side_pixels,6*side_pixels);
for horiz=1:6
    PC=zeros(side_pixels,side_pixels);
    for I=1:side_pixels
        PC(:,I)=weights(horiz,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC=(PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels)=PC;
end

subplot(2,1,1); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])

%Double scale:

%Simulation parameters
side_pixels=32;
num_units=6;

%Save the 15 images into a database
num_image=15;
standard_image_base=SaveStandardImageBase();

%Extract mean grey level from 20000 samples.
meangrey=MeanGreyLevel(side_pixels, standard_image_base, num_image);

%Learn weights
weights=LearningProcess(num_units,side_pixels,standard_image_base,num_image,meangrey);

%Plot principal components
finalimage=zeros(side_pixels,6*side_pixels);
for horiz=1:6
    PC=zeros(side_pixels,side_pixels);
    for I=1:side_pixels
        PC(:,I)=weights(horiz,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC=(PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels)=PC;
end

subplot(2,1,2); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])

saveas(gcf,'Figure6.png')