## Simply run all of the Julia figures
## julia runall.jl
## If any packages are missing, run setup.jl
## [2020-07-14 Tue]


using ImageFiltering
using Plots
using Images
using ImageMagick
using Printf
using LinearAlgebra             # for norm(.)
using Statistics       


include("hancock.jl")

PlotFigure1()
PlotFigure2()
PlotFigure3()
PlotFigure4()
PlotFigure5()
PlotFigure6()
PlotFigure7()
PlotFigure8()


