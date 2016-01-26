rredlist
========




[![Build Status](https://travis-ci.org/ropenscilabs/rredlist.svg?branch=master)](https://travis-ci.org/ropenscilabs/rredlist)

## Install

CRAN


```r
install.packages("rredlist")
```

Development version


```r
devtools::install_github("ropenscilabs/rredlist")
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
#> 2 22694927 Fratercula arctica ANIMALIA CHORDATA  AVES CHARADRIIFORMES
#>    family      genus main_common_name        authority published_year
#> 1 ALCIDAE Fratercula  Atlantic Puffin (Linnaeus, 1758)           2015
#> 2 ALCIDAE Fratercula  Atlantic Puffin (Linnaeus, 1758)           2015
#>   category criteria marine_system freshwater_system terrestrial_system
#> 1       VU  A4abcde          TRUE             FALSE               TRUE
#> 2       VU  A4abcde          TRUE             FALSE               TRUE
#>                 assessor  reviewer
#> 1 BirdLife International Symes, A.
#> 2 BirdLife International Symes, A.
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
#> [1] "{\"name\":\"Fratercula arctica\",\"result\":[{\"taxonid\":22694927,\"scientific_name\":\"Fratercula arctica\",\"kingdom\":\"ANIMALIA\",\"phylum\":\"CHORDATA\",\"class\":\"AVES\",\"order\":\"CHARADRIIFORMES\",\"family\":\"ALCIDAE\",\"genus\":\"Fratercula\",\"main_common_name\":\"Atlantic Puffin\",\"authority\":\"(Linnaeus, 1758)\",\"published_year\":2015,\"category\":\"VU\",\"criteria\":\"A4abcde\",\"marine_system\":true,\"freshwater_system\":false,\"terrestrial_system\":true,\"assessor\":\"BirdLife International\",\"reviewer\":\"Symes, A.\"},{\"taxonid\":22694927,\"scientific_name\":\"Fratercula arctica\",\"kingdom\":\"ANIMALIA\",\"phylum\":\"CHORDATA\",\"class\":\"AVES\",\"order\":\"CHARADRIIFORMES\",\"family\":\"ALCIDAE\",\"genus\":\"Fratercula\",\"main_common_name\":\"Atlantic Puffin\",\"authority\":\"(Linnaeus, 1758)\",\"published_year\":2015,\"category\":\"VU\",\"criteria\":\"A4abcde\",\"marine_system\":true,\"freshwater_system\":false,\"terrestrial_system\":true,\"assessor\":\"BirdLife International\",\"reviewer\":\"Symes, A.\"}]}"
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
#> 2 22694927 Fratercula arctica ANIMALIA CHORDATA  AVES CHARADRIIFORMES
#>    family      genus main_common_name        authority published_year
#> 1 ALCIDAE Fratercula  Atlantic Puffin (Linnaeus, 1758)           2015
#> 2 ALCIDAE Fratercula  Atlantic Puffin (Linnaeus, 1758)           2015
#>   category criteria marine_system freshwater_system terrestrial_system
#> 1       VU  A4abcde          TRUE             FALSE               TRUE
#> 2       VU  A4abcde          TRUE             FALSE               TRUE
#>                 assessor  reviewer
#> 1 BirdLife International Symes, A.
#> 2 BirdLife International Symes, A.
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
#>             "published_year": 2015,
#>             "category": "VU",
#>             "criteria": "A4abcde",
#>             "marine_system": true,
#>             "freshwater_system": false,
#>             "terrestrial_system": true,
...
```

## Meta

* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
