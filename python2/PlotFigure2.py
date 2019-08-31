import numpy as np
import SaveStandardImageBase
from MeanGreyLevel import MeanGreyLevel
from LearningProcess import LearningProcess

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import imageio

import path
OUTDIR = path.Path( __file__).realpath().dirname() / "output"
OUTDIR.makedirs() if not OUTDIR.isdir() else None

def main(nIter=5,
         iterPerFrame=5):
    side_pixels = 64
    num_units = 15
    num_image = 15
#     from Gaussian import Gaussian
#     finalImage = Gaussian(64)
    if 1:
        with imageio.get_writer(OUTDIR / 'Figure2_movie.gif', mode='I',fps=20,) as writer:
            def arr__castImage(w,MIN,MAX):
                w  = (np.minimum(w,MAX)-MIN)/(MAX-MIN)*255
                w = w.astype('uint8')                
                return w
            
            def _reshape(weights):
                finalImage = weights.reshape((3,5,64,64))
                finalImage = np.concatenate(finalImage,axis=-2)
                finalImage = np.concatenate(finalImage,axis=-1)
                return finalImage
            
            def callback(i,image, weights):
                if not (i %  iterPerFrame):
#                     weightHist.append(weights)
                    w  = _reshape(weights)
                    w =  arr__castImage(w,-0.2,0.2)
                    image = imageio.core.Image( w )
                    writer.append_data(image)
                    


            image_db = SaveStandardImageBase.main("../")
            meangrey = MeanGreyLevel( side_pixels, image_db, num_image)
            weights = LearningProcess( num_units, 
                                      side_pixels, 
                                      image_db, 
                                      num_image, 
                                      meangrey,
                                     nIter=nIter,
                                     callback = callback)

    fig,axs = plt.subplots(1,1,figsize=[12,4])
    ax = axs
    ax.imshow(_reshape(weights))
    fig.savefig(OUTDIR / "Figure2.png")
    
    
if __name__ == '__main__':
    main()

# for nh in range(5):
#     for nv in range(3):
#         PC =np.zeros(64,64)
#         for I in range