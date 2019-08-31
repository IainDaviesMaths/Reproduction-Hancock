
### Reproduction-Hancock

Reproduction of Hancock, P. et al, 1991 The Principal Components of Natural Images

![image](./python2/output/Figure2_movie.gif)

[file:python2/output/Figure2_movie.gif]


### `matlab/`

To use this code, clone the repository then run the makefile using "make all".

The paper by Hancock et al aims to replicate receptive fields of V1 cells using the method of Principle Component Analysis (PCA) in a neural network. It uses an algorithm by Sanger to produce 15 output neurons representing the first 15 PCs of a series of greyscale images. The approach taken in the code stored in this repository is to reproduce Sanger's algorithm in MATLAB code and apply it to a random selection of the original natural images used to create Figures 2-6 following the method in Hancock. The original natural images are stored here under images1-15, new1-15 and two0-9. For Figures 7 and 8, the original text image could not be obtained, so a new one was created by copy-and-pasting text into a Word Document and editing it so it had similar features to the original text. This included adding large whitespaces and finding a similar font. This was then converted into a PNG file and random sections of it at different scales were used as input to Sanger's algorithm to produce Figures 7 and 8.

All of the main features of the original Figures 2-8 were reproduced by this code. A few differences were found as follows: 1)Some images of PCs in the Figures are the negative images of those in the originals, but by the nature of Sanger's algorithm these represent the same PCs. 2)Some of the latter PCs are in a different order to the originals. PCs are ordered by the variance in the feature they represent, and some of the PCs with very similar variances were swapped. This may be down to the randomness of the selected images. The only PC in a significantly different position is the one corresponding to spaces between words in Figure 7. In the original it is the 7th PC, whereas in the reproduced Figure it is the 5th PC. This may be down to the fact that a different text image was used.

The main challenge in reproducing the results was making the text image similar enough to the original. Text with no large whitespace or font that was too thin failed to produce a PC that corresponded to word spacings.

The computations were completed on a HP Pavilion Notebook with an Intel Core i3. Computation time was typically 5 minutes per Figure.

### `python2/` 

#### Usage:
    - No CLI at the moment
    
#### ToDo:
    - Add makefile/testing suites
    - Finish all figures

#### Changes:

1. Added movies

1. Vectorised python2/sageupate.py

1. Added iteration number as arguments.