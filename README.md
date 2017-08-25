rredlist
========



[![Build Status](https://travis-ci.org/ropensci/rredlist.svg?branch=master)](https://travis-ci.org/ropensci/rredlist)
[![codecov.io](https://codecov.io/github/ropensci/rredlist/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rredlist?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rredlist)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rredlist)](https://cran.r-project.org/package=rredlist)

[IUCN Red List docs][docs]

## Authentication

IUCN requires you to get your own API key, an alphanumeric string that you
need to send in every request. Get it at <http://apiv3.iucnredlist.org/api/v3/token>.
Keep this key private. You can pass the key in to each function via the
`key` parameter, but it's better to store the key either as a environment
variable (`IUCN_REDLIST_KEY`) or an R option (`iucn_redlist_key`) - we
suggest using the former option.

## High vs. Low level package APIs

__High level API__

High level functions do the HTTP request and parse data to a data.frame for
ease of downstream use. The high level functions have no underscore on the end
of the function name, e.g., `rl_search`

__Low level API__

The parsing to data.frame in the high level API does take extra time. The low
level API only does the HTTP request, and gives back JSON without doing any
more parsing. The low level functions DO have an underscore on the end
of the function name, e.g., `rl_search_`

## No Spatial

This package does not include support for the spatial API, described at
[http://apiv3.iucnredlist.org/spatial][spatial].

## Citing IUCN API

use the function `rl_citation()`


```r
rl_citation()
#> [1] "IUCN 2015. IUCN Red List of Threatened Species. Version 2017-1 <www.iucnredlist.org>"
```


## Install

CRAN


```r
install.packages("rredlist")
```

Development version


```r
devtools::install_github("ropensci/rredlist")
```


```r
library("rredlist")
```

## High level API

High level functions do the HTTP request and parse to data to a data.frame for ease
of downstream use.


```r
rl_search('Fratercula arctica')
#> $name
#> [1] "Fratercula arctica"
#> 
#> $result
#>    taxonid    scientific_name  kingdom   phylum class           order
#> 1 22694927 Fratercula arctica ANIMALIA CHORDATA  AVES CHARADRIIFORMES
#>    family      genus main_common_name        authority published_year
#> 1 ALCIDAE Fratercula  Atlantic Puffin (Linnaeus, 1758)           2017
#>   category criteria marine_system freshwater_system terrestrial_system
#> 1       VU  A4abcde          TRUE             FALSE               TRUE
#>                 assessor                 reviewer aoo_km2  eoo_km2
#> 1 BirdLife International Butchart, S. & Symes, A.      NA 20800000
#>   elevation_upper elevation_lower depth_upper depth_lower errata_flag
#> 1              NA              NA          NA          NA       FALSE
#>   errata_reason
#> 1            NA
```

Likely a bit faster is to parse to a list only, and not take the extra data.frame parsing time


```r
rl_search('Fratercula arctica', parse = FALSE)
#> $name
#> [1] "Fratercula arctica"
#> 
#> $result
#> $result[[1]]
#> $result[[1]]$taxonid
#> [1] 22694927
#> 
#> $result[[1]]$scientific_name
#> [1] "Fratercula arctica"
...
```

## Low level API

The parsing to data.frame in the high level API does take extra time. The low level API
only does the HTTP request, and gives back JSON without doing any more parsing


```r
rl_search_('Fratercula arctica')
#> [1] "{\"name\":\"Fratercula arctica\",\"result\":[{\"taxonid\":22694927,\"scientific_name\":\"Fratercula arctica\",\"kingdom\":\"ANIMALIA\",\"phylum\":\"CHORDATA\",\"class\":\"AVES\",\"order\":\"CHARADRIIFORMES\",\"family\":\"ALCIDAE\",\"genus\":\"Fratercula\",\"main_common_name\":\"Atlantic Puffin\",\"authority\":\"(Linnaeus, 1758)\",\"published_year\":2017,\"category\":\"VU\",\"criteria\":\"A4abcde\",\"marine_system\":true,\"freshwater_system\":false,\"terrestrial_system\":true,\"assessor\":\"BirdLife International\",\"reviewer\":\"Butchart, S. & Symes, A.\",\"aoo_km2\":null,\"eoo_km2\":\"20800000\",\"elevation_upper\":null,\"elevation_lower\":null,\"depth_upper\":null,\"depth_lower\":null,\"errata_flag\":false,\"errata_reason\":null}]}"
```

To consume this JSON, you can use `jsonlite`


```r
library("jsonlite")
jsonlite::fromJSON(rl_search_('Fratercula arctica'))
#> $name
#> [1] "Fratercula arctica"
#> 
#> $result
#>    taxonid    scientific_name  kingdom   phylum class           order
#> 1 22694927 Fratercula arctica ANIMALIA CHORDATA  AVES CHARADRIIFORMES
#>    family      genus main_common_name        authority published_year
#> 1 ALCIDAE Fratercula  Atlantic Puffin (Linnaeus, 1758)           2017
#>   category criteria marine_system freshwater_system terrestrial_system
#> 1       VU  A4abcde          TRUE             FALSE               TRUE
#>                 assessor                 reviewer aoo_km2  eoo_km2
#> 1 BirdLife International Butchart, S. & Symes, A.      NA 20800000
#>   elevation_upper elevation_lower depth_upper depth_lower errata_flag
#> 1              NA              NA          NA          NA       FALSE
#>   errata_reason
#> 1            NA
```

Or other tools, e.g., `jq` via the `jqr` R client


```r
# devtools::install_github("ropensci/jqr")
library("jqr")
rl_search_('Fratercula arctica') %>% dot()
#> {
#>     "name": "Fratercula arctica",
#>     "result": [
#>         {
#>             "taxonid": 22694927,
#>             "scientific_name": "Fratercula arctica",
#>             "kingdom": "ANIMALIA",
#>             "phylum": "CHORDATA",
#>             "class": "AVES",
#>             "order": "CHARADRIIFORMES",
#>             "family": "ALCIDAE",
#>             "genus": "Fratercula",
#>             "main_common_name": "Atlantic Puffin",
#>             "authority": "(Linnaeus, 1758)",
#>             "published_year": 2017,
#>             "category": "VU",
#>             "criteria": "A4abcde",
#>             "marine_system": true,
#>             "freshwater_system": false,
#>             "terrestrial_system": true,
...
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rredlist/issues).
* License: MIT
* Get citation information for `rredlist` in R doing `citation(package = 'rredlist')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[docs]: http://apiv3.iucnredlist.org/api/v3/docs
[token]: http://apiv3.iucnredlist.org/api/v3/token
[spatial]: http://apiv3.iucnredlist.org/spatial
