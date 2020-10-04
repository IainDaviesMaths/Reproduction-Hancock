%Plot Figure 1

%Save the 15 images into a database
image_base = SaveStandardImageBase();

%Create montage.
montage = zeros(256*3,256*5);
for horiz = 1:5
    for vert = 1:3
        %Pick out image.
        image = image_base(:,:,horiz+(vert-1)*5);
        %Fill in montage with image.
        montage((vert-1)*256+1:vert*256,(horiz-1)*256+1:horiz*256) = image;
    end
end

imshow(montage,[])
set(gca,'visible','off')
set(gca,'xtick',[])
saveas(gcf,'../matlab-figures/Figure1.png')