import numpy as np
def sagerupdate(image_vec, weights, lr):
    '''
    %SAGERUPDATE updates the weights of the connections between input pixels
%and output units given the presentation of an image according to Sanger's
%rule.
    '''
    num_pixels = len(image_vec)
    weight_size = weights.shape
    num_units = weight_size[0]
    output_values = np.dot(weights ,image_vec)
#     for oja_input in image_vec:
#         for j in range
#         pass
    for i in range(num_pixels):
        oja_input = image_vec[i]
        for j in range(num_units):
            oja_input = oja_input - output_values[j]*weights[j,i]
            weights[j,i] = weights[j,i] + lr * output_values[j] * oja_input
            
    return weights