import numpy as np
def MeanGreyLevel(nPixel, imDB, nImage,nIter=20000):
    greylevel = 0.
    for i in range(nIter):
        image_no = np.random.randint(nImage)
        ix,iy = np.random.randint(267-nPixel, size=(2,))
        image = imDB[ix:ix+nPixel,
                     iy:iy+nPixel,
                    image_no]
        greylevel = greylevel + float(np.sum(image)) / nPixel**2 / nIter
    
    return greylevel