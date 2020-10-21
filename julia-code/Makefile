######################################################################
## Running the Julia code.

JULIA-FIGS := julia-fig1.png julia-fig2.png julia-fig3.png julia-fig4.png \
              julia-fig5.png julia-fig6.png julia-fig7.png julia-fig8.png \
              julia-fig9.png

.PHONY: clean-julia run-julia

## This generates all of the figures
run-julia: 
	julia runall.jl

## This removes all the julia figures.
clean-julia:
	rm -f $(JULIA-FIGS)

julia-figures.ipynb: julia-figures.md
	jupytext --to notebook  $^
