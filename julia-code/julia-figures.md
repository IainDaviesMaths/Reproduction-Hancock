---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.1'
      jupytext_version: 1.1.0
  kernelspec:
    display_name: Julia 1.1.0
    language: julia
    name: julia-1.1
---


# Introduction

Add the packages that we require for this session:

```julia
using ImageFiltering
using Plots
using Images
using ImageMagick
using Printf
using LinearAlgebra             # for norm(.)
using Statistics
using Random
```



## Include the source code

```julia
include("hancock.jl")
```



## Figure 1

```julia
PlotFigure1()
plot(load("julia-fig1.png"))
```

## Figure 2


```julia
PlotFigure2()
plot(load("julia-fig2.png"))
```

## Figure 3


```julia
PlotFigure3()
plot(load("julia-fig3.png"))
```



## Figure 4


```julia
PlotFigure4()
plot(load("julia-fig4.png"))
```

## Figure 5


```julia
PlotFigure5()
plot(load("julia-fig5.png"))
```

## Figure 6


```julia
PlotFigure6()
plot(load("julia-fig6.png"))
```

## Figure 7


```julia
PlotFigure7()
plot(load("julia-fig7.png"))
```

## Figure 8


```julia
PlotFigure8()
plot(load("julia-fig8.png"))
```

## Figure 9


```julia
PlotFigure9()
plot(load("julia-fig9.png"))
```

## Notes

Convert the markdown using `jupytext --to notebook  julia-figures.md`

launch the notebook using `jupyter notebook julia-figures.ipynb`

Get the list of kernelspecs using `jupyter kernelspec list`; to add
the Julia kernel, add the IJulia package for that version of Julia.


