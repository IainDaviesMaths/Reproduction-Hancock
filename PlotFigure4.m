%Plot Figure 4

%Simulation parameters
side_pixels=64;
num_units=6;

%Save the 15 images into a database
num_image=15;
standard_image_base=SaveStandardImageBase();

%Extract mean grey level from 20000 samples.
meangrey=MeanGreyLevel(side_pixels, standard_image_base, num_image);

%Learn weights
weights=LearningProcessRotated(num_units,side_pixels,standard_image_base,num_image,meangrey);

%Plot principal components
finalimage=zeros(64*1,64*6);
for horiz=1:6
    for vert=1:1
        PC=zeros(64,64);
        for I=1:64
            PC(:,I)=weights((vert-1)*5+horiz,(I-1)*64+1:I*64);
        end
        %Rescale each PC.
        PC=(PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
        %Fill in final image with PC.
        finalimage((vert-1)*64+1:vert*64,(horiz-1)*64+1:horiz*64)=PC;
    end
end

imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])
saveas(gcf,'Figure4.png')