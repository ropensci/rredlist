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
#'   Also supports any [curl options][curl::curl_options()] passed to the GET
#'   request via [HttpClient][crul::HttpClient()].
