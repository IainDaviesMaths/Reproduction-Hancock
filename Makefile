# Makefile for Hancock et al reproductions

all: Figure2.png Figure3.png Figure4.png Figure5.png Figure6.png Figure7.png Figure8.png

Figure%.png: PlotFigure%.m 
	matlab -nodisplay -nosplash -nodesktop -r "run('$<'); exit;"

julia-figures.ipynb: julia-figures.md
	jupytext --to notebook  $^

