# rredlist <img src="man/figures/logo.png" align="right" width="120" />



[![Status at rOpenSci Software Peer Review](https://badges.ropensci.org/663_status.svg)](https://github.com/ropensci/software-review/issues/663)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![cran version](https://www.r-pkg.org/badges/version/rredlist)](https://cran.r-project.org/package=rredlist)
[![R-check](https://github.com/ropensci/rredlist/actions/workflows/R-check.yml/badge.svg)](https://github.com/ropensci/rredlist/actions/workflows/R-check.yml)
[![codecov.io](https://codecov.io/gh/ropensci/rredlist/coverage.svg)](https://app.codecov.io/gh/ropensci/rredlist)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/rredlist)](https://github.com/r-hub/cranlogs.app)

`rredlist` is an R client for the IUCN Red List API (https://api.iucnredlist.org). The [IUCN Red List](https://www.iucnredlist.org/) is the world’s most comprehensive information source on the global extinction risk status of animal, fungus, and plant species. This package provides access via R to the various data contained within this database which span range details, population size, habitat and ecology, use and/or trade, threats, and conservation actions. The functions within the package cover all endpoints of the IUCN Red List web API, which are documented [here](https://api.iucnredlist.org/api-docs/index.html).

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

**Keep this key private.** You can pass the key in to each function via the key parameter, but it’s better to store the key either as an environment variable (`IUCN_REDLIST_KEY`) or an R option (`iucn_redlist_key`) - we recommend using the former option. Note that there is not a default API key that is used as a fallback, and the package will not function without providing/storing your own API key.

## Example usage

### Loading the package

``` r
library("rredlist")
```

### Search for assessments for a particular species

``` r
rl_species("Gorilla", "gorilla")$assessments
#>    year_published latest possibly_extinct possibly_extinct_in_the_wild sis_taxon_id
#> 1            2016  FALSE            FALSE                        FALSE         9404
#> 2            2018   TRUE            FALSE                        FALSE         9404
#> 3            2016  FALSE            FALSE                        FALSE         9404
#> 4            2008  FALSE            FALSE                        FALSE         9404
#> 5            2007  FALSE            FALSE                        FALSE         9404
#> 6            2000  FALSE            FALSE                        FALSE         9404
#> 7            1996  FALSE            FALSE                        FALSE         9404
#> 8            1994  FALSE            FALSE                        FALSE         9404
#> 9            1990  FALSE            FALSE                        FALSE         9404
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
#>     year_published latest possibly_extinct possibly_extinct_in_the_wild sis_taxon_id
#> 1             2019   TRUE            FALSE                        FALSE    132523146
#> 2             2019   TRUE            FALSE                        FALSE        10767
#> 3             2013   TRUE            FALSE                        FALSE         1078
#> 4             2019   TRUE            FALSE                        FALSE    132521900
#> 5             2020  FALSE            FALSE                        FALSE         1086
#> 6             2019   TRUE            FALSE                        FALSE         1117
#> 7             2019   TRUE            FALSE                        FALSE        11797
#> 8             2021   TRUE            FALSE                        FALSE        12124
#> 9             2019   TRUE            FALSE                        FALSE        12695
...
```

## Logo

<img src="man/figures/logo.png" align="right" width="120" />

The `rredlist` logo showcases a silhouette of a [Javan rhinoceros](https://www.iucnredlist.org/species/19495/18493900) (_Rhinoceros sondaicus_), one of the most endangered mammal species on the planet. The species has suffered extreme population decline due to habitat loss and poaching, with only ~75 individuals alive in the wild today, all in [Ujung Kulon National Park](https://tnujungkulon.menlhk.go.id/), a [UNESCO World Heritage Site](https://whc.unesco.org/en/list/608) in Java, Indonesia. Despite recent conservation efforts, [poaching continues](https://www.savetherhino.org/asia/indonesia/poaching-gangs-claim-to-have-killed-one-third-of-the-remaining-javan-rhino-population/); further, the small population is extremely susceptible to inbreeding, disease, and further habitat loss due to the rampant spreading of local palm trees. You can read more about the Javan rhino on the [IUCN Red List](https://www.iucnredlist.org/species/19495/18493900), [World Wildlife Fund](https://www.worldwildlife.org/species/javan-rhino), and [International Rhino Foundation](https://rhinos.org/about-rhinos/rhino-species/javan-rhino/).

This work, "rredlist logo", is adapted from ["Javan rhino silhouette"](https://creazilla.com/media/silhouette/64313/javan-rhino) by [Creazilla](https://creazilla.com/), used under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). "rredlist logo" is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) by William Gearty.

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rredlist/issues).
* License: MIT
* Get citation information for `rredlist` in R doing `citation(package = 'rredlist')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
