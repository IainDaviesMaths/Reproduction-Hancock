# Makefile for Hancock et al reproductions

all: Figure1.png Figure2.png Figure3.png Figure4.png Figure5.png Figure6.png Figure7.png Figure8.png Figure9.png

Figure%.png: matlab-code/PlotFigure%.m 
	matlab -nodisplay -nosplash -nodesktop -r "run('$<'); exit;"



######################################################################
## Running the Julia code.

JULIA-FIGS := julia-figs/julia-fig1.png julia-figs/julia-fig2.png \
	      julia-figs/julia-fig3.png julia-figs/julia-fig4.png \
              julia-figs/julia-fig5.png julia-figs/julia-fig6.png \
	      julia-figs/julia-fig7.png julia-figs/julia-fig8.png \
	      julia-figs/julia-fig9.png

.PHONY: clean-julia run-julia

## This generates all of the figures
run-julia: 
	julia julia-code/runall.jl

## This removes all the julia figures.
clean-julia:
	rm -f $(JULIA-FIGS)

julia-figures.ipynb: julia-code/julia-figures.md
	jupytext --to notebook  $^

