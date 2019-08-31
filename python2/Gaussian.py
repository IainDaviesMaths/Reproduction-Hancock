import numpy as np
def Gaussian(size):
#     np.arange(0,size)
#     np.linspace(0,size)
    sigma = size * 5 /32
    arr = np.zeros((size,size))
    y0 = x0 = (size + 1.) /2.
    for x in range(size):
        for y in range(size):
            arr[x,y] = np.exp(-(( x-x0)**2 + (y-y0)**2 )/(2*sigma**2))
    return arr
