rredlist 0.7.0
===================

### MINOR IMPROVEMENTS

* vignette added, but only available on the docs site (#24)
* when testing, if a iucm redlist key not found, set a dummy key (#41)
* readme improvements (#42)
* change base url for Red List API to https from http

rredlist 0.6.0
===================

### MINOR IMPROVEMENTS

* note in docs about how result may differ in website vs. in this package through the API  (#35)
* fail with useful message when NA's passed to parameters in package functions (#38)


rredlist 0.5.0
===================

### NEW FEATURES 

* gains new function `rl_use_iucn` to help with API key setup (#31) by @maelle
* gains new functions `rl_comp_groups` and `rl_comp_groups_` to interface with the comprehensive groups API route (#26)
* `rl_sp` gains two new parameters: `all` (logical) to toggle getting all results or not, if selected we do paging internally; `quiet` parameter (logical) suppresses progress (#29)

### MINOR IMPROVEMENTS

* mention `redlistr` package in README to help users decide which package to use for which use cases (#30)
* now using `webmockr` and `vcr` to do unit test caching (#33) (#34)



rredlist 0.4.0
==============

### NEW FEATURES

* Gains new functions `rl_growth_forms()` and `rl_growth_forms_()`. added 
tests for them as well (#20) thanks @stevenpbachman

### MINOR IMPROVEMENTS

* Now using markdown documentation (#22)
* Fixed many man files which for `region` parameter described 
requiring a taxonomic name - fixed to describe accurately. Also 
improved docs in general (#21)
* Added the options for `category` parameter in `rl_sp_category()` function 
* Added in docs for `rl_sp_country` how to get acceptable country codes to 
pass to `country` parameter
* Added to package level manual file `?rredlist-package` a note from the 
IUCN Redlist API documentation about that they suggest using taxonomic 
names instead of IDs because IDs can change through time



rredlist 0.3.0
==============

### NEW FEATURES

* New functions `rl_occ_country` and `rl_occ_country_` for 
getting country occurrences by species name or ID (#13)
* Replaced `httr` with `crul`. Please note this only affects use 
of curl options. See `crul` docs for how to use curl options (#14)

### MINOR IMPROVEMENTS

* User agent string like `r-curl/2.3 crul/0.2.0 rOpenSci(rredlist/0.3.0)` 
sent in all requests now to help IUCN API maintainers know 
how often requests come from R and this package (#19)
* Taxon names are now given back in `rl_threats` - we didn't do 
anything in the package - the API now gives the names back and 
adds them in a column (#10)
* Type checking all parameter inputs now both in terms of class
and length - with helpful error messages on fail (#17)
* Simplify package codebase by having single internal function for a 
suite of half a dozen or so functions that have similar pattern (#18)
* Removed `key` parameter from `rl_version()` and `rl_citation()` as
API key not required for those methods
* More thorough test suite


rredlist 0.2.0
==============

### NEW FEATURES

* New methods added to get historical assessments: `rl_history()`
and `rl_history_()` (#8)

### MINOR IMPROVEMENTS

* Fixed description of what `rl_common_names` does. In addition, 
clarified descriptino of what other functions do as well, whenever
it was unclear (#12)

### BUG FIXES

* Some API tokens were being blocked, fixed now (#7)
* On some operating systems (at least some versions of Windows), queries 
that included taxonomic names weren't being processed correctly. It 
is fixed now (#11)


rredlist 0.1.0
==============

### NEW FEATURES

* Released to CRAN.
