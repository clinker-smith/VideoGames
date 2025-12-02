
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VideoGames

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of VideoGames is to provide a streamlined toolkit for exploring
and analyzing trends in global video game sales and development. Built
for data analysis, it includes a data set along with functions for
visualizing and modeling patterns in game performance, genre evolution,
regional markets, and much more!

## Installation

You can install rclimateca from CRAN with:

``` r
install.packages("VideoGames")
```

You can install the development version of VideoGames from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("clinker-smith/VideoGames")
```

If you can load the package, everything worked!

``` r
library(VideoGames)
```

## Example

This is a basic example which shows you how to use a simple function
within the package:

``` r
library(VideoGames)
print_genre(vgchartz)
#>               Genre Count
#> 1              Misc  9304
#> 2            Action  8557
#> 3         Adventure  6260
#> 4      Role-Playing  5721
#> 5            Sports  5586
#> 6           Shooter  5410
#> 7          Platform  4001
#> 8          Strategy  3685
#> 9            Puzzle  3521
#> 10           Racing  3425
#> 11       Simulation  3158
#> 12         Fighting  2367
#> 13 Action-Adventure  1877
#> 14     Visual Novel   493
#> 15            Music   297
#> 16            Party   151
#> 17              MMO   115
#> 18        Education    35
#> 19       Board Game    33
#> 20          Sandbox    20
```

This will return a list of genres and their count in this dataset.
