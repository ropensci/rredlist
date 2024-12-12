#' @param ... Includes the following filters that are supported by the API
#'   endpoint (refer to the [API
#'   docs](https://api.iucnredlist.org/api-docs/index.html) for more
#'   information):
#'   \itemize{
#'     \item `year_published`: (integer) Set this to return only
#'       assessments from a given year.
#'     \item `latest`: (logical) Set this to `TRUE` to return only the
#'       latest assessment for each taxon.
#'     \item `scope_code`: (integer) Set this to return only assessments
#'       from a particular [scope][rl_scopes()] (e.g., `1` for Global, `2` for
#'       Europe). This is similar to the `region` argument of the old Red List
#'       API and old versions of rredlist.
#'   }
#'   Also includes the following arguments related to the wait time between
#'   request retries if a "Too Many Requests" error is received from the API
#'   (see [HttpClient()$retry()][crul::HttpClient()] for more details):
#'   \itemize{
#'     \item `pause_base`, `pause_cap`, and `pause_min`: basis, maximum, and minimum
#'       for calculating wait time for retry
#'     \item `times`: the maximum number of times to retry
#'     \item `onwait`: a callback function if the request will be retried and a
#'       wait time is being applied
#'   }
#'   Also supports any [curl options][curl::curl_options()] passed to the GET
#'   request via [HttpClient][crul::HttpClient()].
