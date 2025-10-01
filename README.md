
<!-- README.md is generated from README.Rmd. Please edit that file -->

# studyplan: R Package for Quantitative Study Design and Scenario Analysis

<!-- badges: start -->

[![R-CMD-check](https://github.com/jh-adv-data-sci/project-4-r-packages-mingrui9/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jh-adv-data-sci/project-4-r-packages-mingrui9/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/jh-adv-data-sci/project-4-r-packages-mingrui9/graph/badge.svg)](https://app.codecov.io/gh/jh-adv-data-sci/project-4-r-packages-mingrui9)

<!-- badges: end -->

The studyplan package provides a set of validated utilities for
researchers to quickly calculate essential design parameters, including
statistical power and sample size, and to evaluate the feasibility and
budgetary implications of proposed study designs.

## Installation

You can install the development version of studyplan from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("jh-adv-data-sci/project-4-r-packages-mingrui9")
```

## Usage: Key Features

### 1. Sample Size Calculation

Easily determine the required sample size for your primary outcomes
using our validated functions. This module is focused on achieving the
necessary statistical power and precision for common study designs.

``` r
library(studyplan)

# Example: Calculate sample size for a simple comparison
sample_size_result <- calculate_sample_size(
  effect_size_d = 0.5, 
  power = 0.80, 
  alpha = 0.05,
  r_squared = 0.00
)

print(sample_size_result)
#> [1] 63
```

### 2. Budget and Scenario Evaluation

Evaluate the cost and resource intensity of various sample size
decisions. This function helps researchers select the most efficient
design given external constraints.

``` r
# Example: Evaluate two different sample size scenarios against a budget limit
# NOTE: This calculation assumes that 'cost_per_subject' is the base cost 
# for ALL participants, and 'cost_per_mri' is an ADDED cost for the MRI subgroup.
scenarios_df <- data.frame(
  total_n = c(100, 150),
  mri_n = c(10, 20),
  cost_per_subject = c(500, 550), # Base cost for all participants
  cost_per_mri = c(1000, 1100)    # Cost of the MRI procedure only
)

scenarios <- evaluate_budget_scenarios(scenarios_df)
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
