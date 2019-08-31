function [ weights ] = sagerupdate( image_vec, weights, learn_rate )
%SAGERUPDATE updates the weights of the connections between input pixels
%and output units given the presentation of an image according to Sanger's
%rule.

%Extract number of pixels in image.
num_pixels=length(image_vec);

%Extract number of output units.
weights_size=size(weights);
num_units=weights_size(1);

%Calculate output values.
output_values=weights*image_vec;

%Update weights using algorithm suggested by Sager
for input=1:num_pixels
    oja_input=image_vec(input);
    for J=1:num_units
        oja_input=oja_input-output_values(J)*weights(J,input);
        weights(J,input)=weights(J,input)+learn_rate*output_values(J)*oja_input;
    end
end   


end

