# Makefile for Hancock et al reproductions

all: Figure1.png Figure2.png Figure3.png Figure4.png Figure5.png Figure6.png Figure7.png Figure8.png

Figure%.png: matlab-code/PlotFigure%.m 
	matlab -nodisplay -nosplash -nodesktop -r "run('$<'); exit;"



######################################################################
## Running the Julia code.

JULIA-FIGS := julia-fig1.png julia-fig2.png julia-fig3.png julia-fig4.png \
              julia-fig5.png julia-fig6.png julia-fig7.png julia-fig8.png

.PHONY: clean-julia run-julia

## This generates all of the figures
run-julia: 
	julia runall.jl

## This removes all the julia figures.
clean-julia:
	rm -f $(JULIA-FIGS)

julia-figures.ipynb: julia-figures.md
	jupytext --to notebook  $^

