rredlist
========



[![Status at rOpenSci Software Peer Review](https://badges.ropensci.org/663_status.svg)](https://github.com/ropensci/software-review/issues/663)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![cran version](https://www.r-pkg.org/badges/version/rredlist)](https://cran.r-project.org/package=rredlist)
[![R-check](https://github.com/ropensci/rredlist/actions/workflows/R-check.yml/badge.svg)](https://github.com/ropensci/rredlist/actions/workflows/R-check.yml)
[![codecov.io](https://codecov.io/github/ropensci/rredlist/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rredlist?branch=master)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rredlist)](https://github.com/r-hub/cranlogs.app)

`rredlist` is an R client for the IUCN Red List API (https://api.iucnredlist.org). The [IUCN Red List](https://www.iucnredlist.org/) is the world’s most comprehensive information source on the global extinction risk status of animal, fungus and plant species. This package provides access via R to the various data contained within this database which span range details, population size, habitat and ecology, use and/or trade, threats, and conservation actions.

## Installation

CRAN


``` r
install.packages("rredlist")
```

Development version


``` r
remotes::install_github("ropensci/rredlist")
# OR
install.packages("rredlist", repos = "https://ropensci.r-universe.dev/")
```

## Authentication

Use of this package requires an IUCN API key which can be acquired at https://api.iucnredlist.org/users/sign_up. There is a helper function to help you get the key and store it properly:


``` r
rredlist::rl_use_iucn()
```

**Keep this key private.** You can pass the key in to each function via the key parameter, but it’s better to store the key either as a environment variable (`IUCN_REDLIST_KEY`) or an R option (`iucn_redlist_key`) - we recommend using the former option. Note that there is not a default API key that is used as a fallback, and the package will not function without providing/storing your own API key.

## Example usage

### Loading the package

``` r
library("rredlist")
```

### Search for assessments for a particular species

``` r
rl_species("Gorilla", "gorilla")$assessments
#>    year_published latest sis_taxon_id                                                url assessment_id    scopes
#> 1            2016  FALSE         9404  https://www.iucnredlist.org/species/9404/17963949      17963949 Global, 1
#> 2            2016  FALSE         9404 https://www.iucnredlist.org/species/9404/102330408     102330408 Global, 1
#> 3            2018   TRUE         9404 https://www.iucnredlist.org/species/9404/136250858     136250858 Global, 1
#> 4            2008  FALSE         9404  https://www.iucnredlist.org/species/9404/12983787      12983787 Global, 1
#> 5            2007  FALSE         9404  https://www.iucnredlist.org/species/9404/12983966      12983966 Global, 1
#> 6            2000  FALSE         9404  https://www.iucnredlist.org/species/9404/12983737      12983737 Global, 1
#> 7            1996  FALSE         9404  https://www.iucnredlist.org/species/9404/12983764      12983764 Global, 1
#> 8            1994  FALSE         9404  https://www.iucnredlist.org/species/9404/12984167      12984167 Global, 1
#> 9            1990  FALSE         9404  https://www.iucnredlist.org/species/9404/12984186      12984186 Global, 1
...
```

### Search for assessments that recommend particular conservation actions

#### Get a list of all conservation actions

``` r
rl_actions()
#> $conservation_actions
#>                                              en  code
#> 1                         Land/water protection     1
#> 2                          Site/area protection   1_1
#> 3                 Resource & habitat protection   1_2
#> 4                         Land/water management     2
#> 5                          Site/area management   2_1
#> 6          Invasive/problematic species control   2_2
#> 7         Habitat & natural process restoration   2_3
#> 8                            Species management     3
...
```

#### Return assessments with a particular conservation action

``` r
rl_actions("2_2", all = FALSE)$assessments
#>     year_published latest sis_taxon_id                                                   url assessment_id code
#> 1             2019   TRUE    132523146  https://www.iucnredlist.org/species/132523146/497499        497499  2_2
#> 2             2019   TRUE        10767      https://www.iucnredlist.org/species/10767/498370        498370  2_2
#> 3             2013   TRUE         1078       https://www.iucnredlist.org/species/1078/498639        498639  2_2
#> 4             2019   TRUE    132521900  https://www.iucnredlist.org/species/132521900/498826        498826  2_2
#> 5             2020  FALSE         1086       https://www.iucnredlist.org/species/1086/499235        499235  2_2
#> 6             2019   TRUE         1117       https://www.iucnredlist.org/species/1117/500918        500918  2_2
#> 7             2019   TRUE        11797      https://www.iucnredlist.org/species/11797/503908        503908  2_2
#> 8             2021   TRUE        12124      https://www.iucnredlist.org/species/12124/505402        505402  2_2
#> 9             2019   TRUE        12695      https://www.iucnredlist.org/species/12695/507698        507698  2_2
...
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rredlist/issues).
* License: MIT
* Get citation information for `rredlist` in R doing `citation(package = 'rredlist')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
