"Seed the RNG to a fixed value.  For reproducibility."
function seedRNG()
    Random.seed!(1234);    
end


"Save the 15 standard images into standard_image_base."
function SaveStandardImageBase()
    standard_image_base = zeros(256,256,15);

    for p = 1:15
        file = @sprintf("../input-images/images%d.gif", p)
        image = load(file)
        i = Gray.(image)
        standard_image_base[:,:,p] = i
    end

    return standard_image_base
end


"Plot Figure 1"
function PlotFigure1()
    standard_image_base = SaveStandardImageBase()
    mosaic = mosaicview(standard_image_base; nrow = 3)
    save("julia-fig1.png", mosaic)
end



"Find mean grey level of 20000 samples of side_pixel^2 samples of images."
function MeanGreyLevel(side_pixels, image_base, num_image)
	# Extract dimensions of images in the image_base. All images in the 
	# image_base must have same dimension.
	(dim_x, dim_y) = size(image_base);
	    
    greylevel = 0.0;
    for I = 1:20000
        # Select piece of image from database.
        image_no = rand(1:num_image);
		image_x = rand(1:dim_x+1-side_pixels);
		image_y = rand(1:dim_y+1-side_pixels);    
		image = image_base[image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,image_no];
		# Find average grey level.
        greylevel = greylevel+sum(sum(image/(side_pixels^2)))/20000;
    end
    return greylevel
end



"""
Simulate the learning process of the network according to Sanger's rule.

num_unit       Number of output units in the network.
side_pixels    Number of pixels in a side of the presented images.
image_base     The database of images to be sampled from.
num_image      Number of images in the database.
meangrey       The mean grey level of 20000 samples of the given size from
               the database. 
rotation_angle Images will be rotated by this number of degrees
"""
function LearningProcess(num_unit, side_pixels, image_base, num_image,meangrey, rotation_angle)

	##Extract dimensions of images in the image_base. All images in the 
	##image_base must have same dimension.
	(dim_x, dim_y) = size(image_base);

    ##Initialise weights so that the sum of the squares is approximately 1.
    weights = 0.06*(rand(num_unit,side_pixels^2) .- 0.5);
    
    learn_rate = 1;
    for time = 1:120000
        ##Select 64x64 piece of image from database.
        image_no = rand(1:num_image);
        image_x = rand(1:(dim_x+1-side_pixels));
        image_y = rand(1:(dim_y+1-side_pixels));
        image = image_base[image_x:image_x+side_pixels-1,
                         image_y:image_y+side_pixels-1,image_no];
        ## extra for figure 4
        ## https://www.simonwenkel.com/2018/10/15/Introduction-to-Computer-Vision-with-Julia-part1-basic-image-manipulation.html#rotate-images
        image = imrotate(image, rotation_angle*π/180, axes(image), 0.0)
        ##Subtract mean grey level
        image = image  .- meangrey;
        ##Mask the image with a Gaussian.
        image = image.*Gaussian(side_pixels);
        ##Reshape image matrix into a vector.
        image_vec = reshape(image,side_pixels^2,1);
        ## Normalise the image vector to have unit length.
        image_vec = image_vec/norm(image_vec);
        ##Update weights.
        weights = sangerupdate( image_vec, weights, learn_rate );
        
        ##Change learning rate every 20000 presentations.
        if mod(time,20000) ==  0
            learn_rate = learn_rate/2;
        end
    end
    
    return weights
    
end

"Create a SIZE by SIZE array with gaussian values centred in the middle."
function Gaussian( size )
    sigma = size*5.0/32;

    array = zeros(size,size);
    x0 = (size/2)+0.5;
    y0 = x0;

    for x = 1:size
        for y = 1:size
            array[x,y] = exp(-((x-x0)^2+(y-y0)^2)/(2*sigma^2));
        end
    end

    return array

end

"""
SANGERUPDATE updates the weights of the connections between input pixels
and output units given the presentation of an image according to Sanger's
rule.
"""
function sangerupdate( image_vec, weights, learn_rate )

    ## Extract number of pixels in image.
    num_pixels = length(image_vec);

    ## Extract number of output units.
    weights_size = size(weights);
    num_units = weights_size[1];

    ## Calculate output values.
    output_values = weights*image_vec;

    ## Update weights using algorithm suggested by Sanger
    for input = 1:num_pixels
        oja_input = image_vec[input];
        for J = 1:num_units
            oja_input = oja_input-output_values[J]*weights[J,input];
            weights[J,input] = weights[J,input] +
                learn_rate*output_values[J] * oja_input;
        end
    end   

    return weights
end


"Plot Figure 2"
function PlotFigure2()
    side_pixels = 64
    num_units = 15
    
    seedRNG()
    
    # Save the 15 images into a database
    num_image = 15
    standard_image_base = SaveStandardImageBase();

    # Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, standard_image_base, num_image)


    weights = LearningProcess(num_units,side_pixels,standard_image_base,num_image,meangrey,0);

    ## Plot principal components
    finalimage = zeros(64*3,64*5);
    for horiz = 1:5
        for vert = 1:3
            PC = zeros(64,64);
            for I = 1:64
                PC[:,I] = weights[(vert-1)*5+horiz,(I-1)*64+1:I*64];
            end
            # Rescale each PC.
            min = minimum(PC)
            max = maximum(PC)
            PC = (PC .- min) ./ ( max - min);
            # Fill in final image with PC.
            finalimage[(vert-1)*64+1:vert*64,(horiz-1)*64+1:horiz*64] = PC;
        end
    end
    
    ##imshow(finalimage)


    save("julia-fig2.png", finalimage)
end



######################################################################

"Save the 15 standard images into standard_image_base."
function SaveExtendedImageBase()
    extended_image_base = zeros(256,256,40);
    part1 = [@sprintf("../input-images/images%d.gif", x) for x in 1:15]
    part2 = [@sprintf("../input-images/new%d.gif", x) for x in 1:15]
    part3 = [@sprintf("../input-images/two%d.gif", x) for x in 0:9]
    ims  = [ part1; part2; part3 ]

    for p in 1:40
        image = load(ims[p])
        i = Gray.(image)
        extended_image_base[:,:,p] = i
    end
    return extended_image_base
end

"Plot Figure 3."
function PlotFigure3()
    side_pixels = 64
    num_units = 15
    
    seedRNG()
    
    # Save the 15 images into a database
    num_image = 40
    extended_image_base = SaveExtendedImageBase();

    # Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, extended_image_base, num_image)


    weights = LearningProcess(num_units,side_pixels,extended_image_base,num_image,meangrey,0);

    ## Plot principal components
    finalimage = zeros(64*3,64*5);
    for horiz = 1:5
        for vert = 1:3
            PC = zeros(64,64);
            for I = 1:64
                PC[:,I] = weights[(vert-1)*5+horiz,(I-1)*64+1:I*64];
            end
            # Rescale each PC.
            min = minimum(PC)
            max = maximum(PC)
            PC = (PC .- min) ./ ( max - min);
            # Fill in final image with PC.
            finalimage[(vert-1)*64+1:vert*64,(horiz-1)*64+1:horiz*64] = PC;
        end
    end
    
    ##imshow(finalimage)


    save("julia-fig3.png", finalimage)
end

"Plot Figure 4."
function PlotFigure4()
    side_pixels = 64
    num_units = 15
    
    seedRNG()
    
    # Save the 15 images into a database
    num_image = 15
    standard_image_base = SaveStandardImageBase();

    # Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, standard_image_base, num_image)


    weights = LearningProcess(num_units, side_pixels,
                                   standard_image_base,num_image,meangrey, 45);

    ## Plot principal components
    finalimage = zeros(64*1,64*6);
    for horiz = 1:6
        for vert = 1:1
            PC = zeros(64,64);
            for I = 1:64
                PC[:,I] = weights[(vert-1)*5+horiz,(I-1)*64+1:I*64];
            end
            # Rescale each PC.
            min = minimum(PC)
            max = maximum(PC)
            PC = (PC .- min) ./ ( max - min);
            # Fill in final image with PC.
            finalimage[(vert-1)*64+1:vert*64,(horiz-1)*64+1:horiz*64] = PC;
        end
    end
    
    ##imshow(finalimage)


    save("julia-fig4.png", finalimage)
end




"Plot Figure 5."
function PlotFigure5()
    ## Generate weights for 15 image case
    seedRNG()

    ## Simulation parameters
    side_pixels = 64;
    num_units = 15;

    ## Save the 15 images into a database
    num_image = 15;
    standard_image_base = SaveStandardImageBase();

    ## Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, standard_image_base, num_image);

    ## Learn weights
    weights15 = LearningProcess(num_units,side_pixels,standard_image_base,
                              num_image,meangrey,0);

    ## Initialise test outputs
    outputs15 = zeros(10000,15);

    ## Produce 10000 test outputs
    for test = 1:10000
        ## Select 64x64 piece of image from database.
        image_no = rand(1:num_image)
        image_x = rand(1:(257-side_pixels))
        image_y = rand(1:(257-side_pixels))
        image = standard_image_base[image_x:image_x+side_pixels-1,
                                  image_y:image_y+side_pixels-1,image_no]

        ## Subtract mean grey level
        image = image .- meangrey;
        ## Mask the image with a Gaussian.
        image = image .* Gaussian(side_pixels);
        ## Reshape image matrix into a vector.
        image_vec = reshape(image,side_pixels^2,1);
        ## Normalise the image vector to have unit length.
        image_vec = image_vec/norm(image_vec);
        
        ## Find output values
        outputs15[test,:] = (weights15*image_vec)';
    end

    ## Generate weights for 40 image case

    ## Simulation parameters
    side_pixels = 64;
    num_units = 15;

    ## Save the 40 images into a database
    num_image = 40;
    extended_image_base = SaveExtendedImageBase();

    ## Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, extended_image_base, num_image);

    ## Learn weights
    weights40 = LearningProcess(num_units,side_pixels,extended_image_base,num_image,meangrey,0);

    ## Initialise test outputs
    outputs40 = zeros(10000,15);

    ## Produce 10000 test outputs
    for test = 1:10000
        ## Select 64x64 piece of image from database.
        image_no = rand(1:num_image);
        image_x = rand(1:(257-side_pixels));
        image_y = rand(1:(257-side_pixels));
        image = extended_image_base[image_x:image_x+side_pixels-1,
                                  image_y:image_y+side_pixels-1,image_no];
        ## Subtract mean grey level
        image = image .- meangrey;
        ## Mask the image with a Gaussian.
        image = image .* Gaussian(side_pixels);
        ## Reshape image matrix into a vector.
        image_vec = reshape(image,side_pixels^2,1);
        ## Normalise the image vector to have unit length.
        image_vec = image_vec/norm(image_vec);
        
        ##  Find output values
        outputs40[test,:] = (weights40*image_vec)';
    end



    variance15 = var(outputs15, dims = 1);
    variance40 = var(outputs40, dims = 1);
    p = plot(1:15,variance15[:],
             xlabel = "Component Number", ylabel = "Output Variance", label = "15 images",
             xaxis = :log, yaxis = :log, seriestype = :scatter);
    plot!(1:15,variance40[:], label = "40 images", seriestype = :scatter);
    png(p, "julia-fig5.png")
end

"Plot Figure 6"
function PlotFigure6()
    seedRNG()

    ## Double scale:

    ## Simulation parameters
    side_pixels = 128;
    num_units = 6;

    ## Save the 15 images into a database
    num_image = 15;
    standard_image_base = SaveStandardImageBase();

    ## Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, standard_image_base, num_image);

    ## Learn weights
    weights = LearningProcess(num_units,side_pixels,standard_image_base,num_image,meangrey,0);

    ## Plot principal components
    finalimage = zeros(side_pixels,6*side_pixels);
    for horiz = 1:6
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ (max - min)
        ## Fill in final image with PC.
        finalimage[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end

    ## Half scale:

    ## Simulation parameters
    side_pixels = 32;
    num_units = 6;

    ## Save the 15 images into a database
    num_image = 15;
    standard_image_base = SaveStandardImageBase();

    ## Extract mean grey level from 20000 samples.
    meangrey = MeanGreyLevel(side_pixels, standard_image_base, num_image);

    ## Learn weights
    weights = LearningProcess(num_units,side_pixels,standard_image_base,num_image,meangrey,0);

    ## Plot principal components
    finalimage2 = zeros(side_pixels,6*side_pixels);
    for horiz = 1:6
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ (max - min)
        ## Fill in final image with PC.
        finalimage2[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end

    finalimage2 = repeat(finalimage2, inner = [4,4]); #  enlarge for plot.

    ##imshow(finalimage2)
    mosaic = mosaicview(finalimage, finalimage2)
    save("julia-fig6.png", mosaic)

end

"Save the text image with Century font."
function SaveTextImageBase()
    image = load("../input-images/textimage.png");
    i = Gray.(image)
    text_image_base = zeros(size(i)[1], size(i)[2], 2);
    text_image_base[:,:,1] = i
    
    ## Save the text image with Calibri font.
    image = load("../input-images/textimage2.png");
    i = Gray.(image)
    text_image_base[:,:,2] = i

    text_image_base
end

"Plot Figure 7."
function PlotFigure7()
    
    seedRNG()
    
    ## Save the text with Century font.
	num_image = 1;
	text_image_base = SaveTextImageBase();
	text_image = text_image_base[:,:,1];
    
    ## Largest scale
    ## Simulation parameters
    side_pixels = 96;
    num_units = 8;

	## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

    ## Plot principal components with example text before
    finalimage1 = zeros(side_pixels,side_pixels*9);
    image = text_image[20:20+side_pixels-1, 50:50+side_pixels-1,1];
    finalimage1[1:side_pixels,1:side_pixels] = image;
    for horiz = 2:9
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz-1,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ ( max - min);

        ## Fill in final image with PC.
        finalimage1[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end

    ## Middle scale
    ## Simulation parameters
    side_pixels = 48;
    num_units = 8;
    
    ## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

    ## Plot principal components
    finalimage2 = zeros(side_pixels,side_pixels*9);
    image = text_image[20:20+side_pixels-1, 50:50+side_pixels-1,1];
    finalimage2[1:side_pixels,1:side_pixels] = image;
    for horiz = 2:9
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz-1,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ ( max - min);
        ## Fill in final image with PC.
        finalimage2[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end



    ## Smallest scale
    ## Simulation parameters
    side_pixels = 24;
    num_units = 8;

	## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

    ## Plot principal components
    finalimage3 = zeros(side_pixels,side_pixels*9);
    image = text_image[20:20+side_pixels-1, 50:50+side_pixels-1,1];
    finalimage3[1:side_pixels,1:side_pixels] = image;
    for horiz = 2:9
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz-1,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ ( max - min);

        ## Fill in final image with PC.
        finalimage3[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end
   
	
	finalimage2 = repeat(finalimage2, inner = [2,2]);
    finalimage3 = repeat(finalimage3, inner = [4,4]);
    
    
    mosaic = mosaicview(finalimage1, finalimage2, finalimage3, nrow = 3)
    save("julia-fig7.png", mosaic)
end

"Plot Figure 8."
function PlotFigure8() 
    seedRNG()

    ## Save the text with Century font.
	num_image = 1;
	text_image_base = SaveTextImageBase();
	text_image = text_image_base[:,:,1];
    
    ## Simulation parameters
    side_pixels = 96;
    num_units = 15;

	## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);
    
    ## Extract filter which corresponds to spaces between words.
    filter = zeros(side_pixels,side_pixels);
    for I = 1:side_pixels
        filter[:,I] = weights[5,(I-1)*side_pixels+1:I*side_pixels];
    end
    
    ## Convolve full image with filter and take its compliment.
    convolution = imfilter(text_image, centered(filter))

    comp = convolution
    min = minimum(comp)
    max = maximum(comp)
    comp = (comp .- min) ./ (max - min)

    ## invert?
    if (sum(filter)> 0) 
        comp = 1.0 .- comp
    end

    thresh = comp .< 0.25

    f = text_image;
    min = minimum(text_image)
    max = maximum(text_image)
    f = (f .- min) ./ (max - min)
    
    superimp = f - thresh
    min = minimum(superimp)
    max = maximum(superimp)
    superimp = (superimp .- min) ./ (max - min)
    
    mosaic = mosaicview(text_image, comp, superimp, nrow = 1)
    save("julia-fig8.png", mosaic)

   return comp
end

"Plot Figure 9."
function PlotFigure9()
    
    seedRNG()
    
    ## Save the text with Calibri font.
    num_image = 1;
    text_image_base = SaveTextImageBase();
    text_image = text_image_base[:,:,2];
    
    ## Largest scale
    ## Simulation parameters
    side_pixels = 96;
    num_units = 8;

	## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

    ## Plot principal components with example text before
    finalimage1 = zeros(side_pixels,side_pixels*9);
    image = text_image[20:20+side_pixels-1, 50:50+side_pixels-1,1];
    finalimage1[1:side_pixels,1:side_pixels] = image;
    for horiz = 2:9
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz-1,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ ( max - min);

        ## Fill in final image with PC.
        finalimage1[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end

    ## Middle scale
    ## Simulation parameters
    side_pixels = 48;
    num_units = 8;
    
    ## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

    ## Plot principal components
    finalimage2 = zeros(side_pixels,side_pixels*9);
    image = text_image[20:20+side_pixels-1, 50:50+side_pixels-1,1];
    finalimage2[1:side_pixels,1:side_pixels] = image;
    for horiz = 2:9
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz-1,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ ( max - min);
        ## Fill in final image with PC.
        finalimage2[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end



    ## Smallest scale
    ## Simulation parameters
    side_pixels = 24;
    num_units = 8;

	## Extract mean grey level from the 20000 samples.
	meangrey = MeanGreyLevel(side_pixels, text_image, num_image);

	## Learn weights
	weights = LearningProcess(num_units,side_pixels,text_image,num_image,meangrey,0);

    ## Plot principal components
    finalimage3 = zeros(side_pixels,side_pixels*9);
    image = text_image[20:20+side_pixels-1, 50:50+side_pixels-1,1];
    finalimage3[1:side_pixels,1:side_pixels] = image;
    for horiz = 2:9
        PC = zeros(side_pixels,side_pixels);
        for I = 1:side_pixels
            PC[:,I] = weights[horiz-1,(I-1)*side_pixels+1:I*side_pixels];
        end
        ## Rescale each PC.
        min = minimum(PC)
        max = maximum(PC)
        PC = (PC .- min) ./ ( max - min);

        ## Fill in final image with PC.
        finalimage3[1:side_pixels,(horiz-1)*side_pixels+1:horiz*side_pixels] = PC;
    end
   
	
	finalimage2 = repeat(finalimage2, inner = [2,2]);
    finalimage3 = repeat(finalimage3, inner = [4,4]);
    
    
    mosaic = mosaicview(finalimage1, finalimage2, finalimage3, nrow = 3)
    save("julia-fig9.png", mosaic)
end
