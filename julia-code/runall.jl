## Simply run all of the Julia figures
## julia runall.jl
## [2020-07-14 Tue]



## If any packages are missing, they should be loaded by  this chunk.
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using ImageFiltering
using Plots
using Images
using ImageMagick
using Printf
using LinearAlgebra             # for norm(.)
using Statistics       
using Random

include("hancock.jl")

PlotFigure1()
PlotFigure2()
PlotFigure3()
PlotFigure4()
PlotFigure5()
PlotFigure6()
PlotFigure7()
PlotFigure8()
PlotFigure9()


