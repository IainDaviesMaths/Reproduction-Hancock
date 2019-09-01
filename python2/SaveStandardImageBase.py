import numpy as np

# import scipy.nmimage
from scipy.ndimage import imread

import path
def main(DIR=None):
    if DIR is None:
        DIR = "."
    DIR = path.Path(DIR).realpath()
    lst = [
        imread( DIR/'data/images%s.gif'%i) for i in range(1,15+1)
    ]
    arr = np.stack(lst,axis=-1)
    return arr