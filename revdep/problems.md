# taxize

<details>

* Version: 0.9.98
* Source code: https://github.com/cran/taxize
* URL: https://docs.ropensci.org/taxize/ (website), https://github.com/ropensci/taxize (devel), https://taxize.dev (user manual)
* BugReports: https://github.com/ropensci/taxize/issues
* Date/Publication: 2020-09-18 17:40:02 UTC
* Number of recursive dependencies: 100

Run `revdep_details(,"taxize")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      > test_check("taxize")
      taxize options
        taxon_state_messages: TRUE
      ── 1. Failure: use_iucn produces expected URL and message (@test-key_helpers.R#4
      use_iucn() not equal to "http://apiv3.iucnredlist.org/api/v3/token".
      1/1 mismatches
      x[1]: "https://apiv3.iucnredlist.org/api/v3/token"
      y[1]: "http://apiv3.iucnredlist.org/api/v3/token"
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 74 | SKIPPED: 216 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: use_iucn produces expected URL and message (@test-key_helpers.R#4) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

