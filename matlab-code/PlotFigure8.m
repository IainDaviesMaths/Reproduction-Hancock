%Plot Figure 8

%Fix seed
rng(1234);

%Save the text with Century font.
num_image = 1;
text_image_base = SaveTextImageBase();
text_image = text_image_base(:,:,1);

%Simulation parameters
side_pixels = 96;
num_units = 15;

%Extract mean grey level from the 20000 samples.
meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

%Learn weights
weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

%Extract filter which corresponds to spaces between words.
filter = zeros(side_pixels,side_pixels);
for I = 1:side_pixels
    filter(:,I) = weights(5,(I-1)*side_pixels+1:I*side_pixels);
end
filter = (filter-min(min(filter)))/(max(max(filter))-min(min(filter)));

%Convolve full image with filter and take its compliment.
convolution = conv2(text_image,filter,'same');
comp = imcomplement(mat2gray(convolution));
%Superimpose this onto the full image.
superimp = (mat2gray(text_image)+(im2bw(comp,0.045)));

figure(1)
subplot(1,3,1); imshow(mat2gray(text_image)); title('Text Image')
subplot(1,3,2); imshow(mat2gray(comp.^0.4)); title('Convolution')
subplot(1,3,3); imshow(mat2gray(superimp)); title('Superimposition')

saveas(gcf,'../matlab-figures/Figure8.png')
