%Plot Figure 9

%Fix seed
rng(1234);

%Save the text with Calibri font.
num_image = 1;
text_image_base = SaveTextImageBase();
text_image = text_image_base(:,:,2);

%Largest scale
%Simulation parameters
side_pixels = 96;
num_units = 8;

%Extract mean grey level from the 20000 samples.
meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

%Learn weights
weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

%Plot principal components with example text before
finalimage = zeros(side_pixels,side_pixels*9);
image = text_image(20:20+side_pixels-1,50:50+side_pixels-1,1);
finalimage(1:side_pixels,1:side_pixels) = mat2gray(image);
for horiz = 2:9
    PC = zeros(side_pixels,side_pixels);
    for I = 1:side_pixels
        PC(:,I) = weights(horiz-1,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC = (PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels) = PC;
end

subplot(3,1,1); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])




%Middle scale
%Simulation parameters
side_pixels = 48;
num_units = 8;

%Extract mean grey level from the 20000 samples.
meangrey  =  MeanGreyLevel(side_pixels, text_image, num_image);

%Learn weights
weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

%Plot principal components
finalimage = zeros(side_pixels,side_pixels*9);
image = text_image(20:20+side_pixels-1,50:50+side_pixels-1,1);
finalimage(1:side_pixels,1:side_pixels) = mat2gray(image);
for horiz = 2:9
    PC = zeros(side_pixels,side_pixels);
    for I = 1:side_pixels
        PC(:,I) = weights(horiz-1,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC = (PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels) = PC;
end

subplot(3,1,2); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])




%Smallest scale
%Simulation parameters
side_pixels = 24;
num_units = 8;

%Extract mean grey level from the 20000 samples.
meangrey  =  MeanGreyLevel(side_pixels, text_image, num_image);

%Learn weights
weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

%Plot principal components
finalimage = zeros(side_pixels,side_pixels*9);
image = text_image(30:30+side_pixels-1,50:50+side_pixels-1,1);
finalimage(1:side_pixels,1:side_pixels) = mat2gray(image);
for horiz = 2:9
    PC = zeros(side_pixels,side_pixels);
    for I = 1:side_pixels
        PC(:,I) = weights(horiz-1,(I-1)*side_pixels+1:I*side_pixels);
    end
    %Rescale each PC.
    PC = (PC-min(min(PC)))/(max(max(PC))-min(min(PC)));
    %Fill in final image with PC.
    finalimage(1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels) = PC;
end

subplot(3,1,3); imshow(finalimage)
set(gca,'visible','off')
set(gca,'xtick',[])

saveas(gcf,'../matlab-figures/Figure9.png')