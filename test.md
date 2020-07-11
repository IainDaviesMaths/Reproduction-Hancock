---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.1'
      jupytext_version: 1.1.0
  kernelspec:
    display_name: Julia 1.4.2
    language: julia
    name: julia-1.4
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
```



## Include the source code

```julia
include("hancock.jl")
```



## Figure 1

```julia
PlotFigure1()
```

Here is the figure:

![figure 1](julia-fig1.png)


## Figure 2


```julia
PlotFigure2()
```

Here is the figure:

![figure 2](julia-fig2.png)


## Notes

Convert the markdown using `jupytext --to notebook  test.md`

launch the notebook using `jupyter notebook test.ipynb`

Get the list of kernelspecs using `jupyter kernelspec list`; to add
the Julia kernel, add the IJulia package for that version of Julia.


