import numpy as np
# import 
from Gaussian import Gaussian
from sagerupdate import sagerupdate
def l2__norm(x,axis=None,keepdims=1,**kw):
    return np.sqrt(np.sum(np.square(x),
                          axis=axis,keepdims=keepdims,**kw))
def LearningProcess( num_unit,
                     side_pixels, 
                    image_base,
                    num_image,
                    meangrey,
                    nIter = 120000,
                   lr = 1.):
    '''
    %num_unit       Number of output units in the network.
    %side_pixels    Number of pixels in a side of the presented images.
    %image_base     The database of images to be sampled from.
    %num_image      Number of images in the database.
    %meangrey       The mean grey level of 20000 samples of the given size from the database. 
    nIter: number of iterations
    lr: learning rate
    '''
    size = (num_unit,side_pixels**2)
    weights=0.06*(np.random.random(size)-0.5);
    mask =  Gaussian(side_pixels)
    for iIter in range(nIter):
        if not iIter %10:
            print ("%s\t/\t%s"%(iIter,nIter))
        image_no = np.random.randint(num_image)
        image_x = np.random.randint(257 - side_pixels)
        image_y = np.random.randint(257 - side_pixels)
        image = image_base[
            image_x:image_x + side_pixels,
            image_y:image_y + side_pixels,
            image_no,
        ]
        image =  image - meangrey
        image =  image * mask
        image_vec = np.reshape( image, (side_pixels**2,1))
        image_vec = image_vec / l2__norm(image_vec)
        weights = sagerupdate( image_vec, weights, lr)
        if iIter%20000 ==0:
            lr = lr /2.
    return weights
    
    