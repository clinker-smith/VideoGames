
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VideoGames

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of the `VideoGames` package is to provide helpful functions for analyzing data from the 2024 Global Video Game Sales data.

## Installation

You can install the development version of VideoGames from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("clinker-smith/VideoGames")
```

## Example

This is an example of one of the functions included in this package, `print_genre`:

``` r
library(VideoGames)
print_genre(vg_data)
```
This will return a list of genres and their count in this datasst.
