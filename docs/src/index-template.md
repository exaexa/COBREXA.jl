```@raw html
<br>
<div align="center">
    <img class="docs-light-only" src="assets/header.svg?maxAge=0" width="80%">
    <img class="docs-dark-only" src="assets/header-dark.svg?maxAge=0" width="80%">
</div>
<br>
```

# Constraint-Based Reconstruction and EXascale Analysis

COBREXA is a toolkit for working with large constraint-based metabolic models,
and a running very large number of analysis tasks on these models in parallel.
Its main purpose is to make the methods of Constraint-based Reconstruction and
Analysis (COBRA) scale to problem sizes that require the use of huge computer
clusters and HPC environments, which allows them to be realistically applied to
pre-exascale-sized models.

In this package, you will find the usual COBRA-like functions that interface to
underlying linear programming solvers. We use
[`JuMP.jl`](https://github.com/jump-dev/JuMP.jl) as the unified interface for
many solvers; you can plug in whichever compatible solver you want, including
the popular [`Tulip.jl`](https://github.com/ds4dm/Tulip.jl),
[`GLPK.jl`](https://github.com/jump-dev/GLPK.jl),
[`OSQP.jl`](https://github.com/oxfordcontrol/OSQP.jl), and
[`Gurobi.jl`](https://github.com/jump-dev/Gurobi.jl).

```@raw html
<div align="center">
<img style="width:300px;margin:10px;border-offset:15px;border: 1px solid #eee;border-radius: 50%;padding: 10px;-webkit-border-radius: 50%;-moz-border-radius: 50%;" src="assets/output.gif" alt="history"><br>
Development history of COBREXA.jl.
</div>
```

## Quick start guide

<!--insert_quickstart-->

## Tutorials

Detailed tutorial content is [available here](tutorials.md).

```@contents
Pages = joinpath.("tutorials", filter(x -> endswith(x, ".md"), readdir("tutorials")))
Depth = 1
```

## Example notebooks and workflows

Detailed notebook content is [available here](notebooks.md).

```@contents
Pages = joinpath.("notebooks", filter(x -> endswith(x, ".md"), readdir("notebooks")))
Depth = 1
```

## Functions reference

```@contents
Pages = ["functions.md"]
```

## Contribution guide

If you wish to contribute code, patches or improvements to `COBREXA.jl`, please
read the basic [contribution guidelines and hints.](howToContribute.md).
