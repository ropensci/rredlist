#' @param ... Includes the following filters that are supported by the API
#'   endpoint (refer to the [API
#'   docs](https://api.iucnredlist.org/api-docs/index.html) for more
#'   information):
#'   \itemize{
#'     \item \code{year_published}: (integer) Set this to return only
#'       assessments from a given year.
#'     \item \code{latest}: (logical) Set this to \code{TRUE} to return only the
#'       latest assessment for each taxon.
#'     \item \code{scope_code}: (integer) Set this to return only assessments
#'       from a particular [scope][rl_scopes()] (e.g., `1` for Global, `2` for
#'       Europe).
#'   }
#'   Also supports any [curl options][curl::curl_options()] passed to the GET
#'   request via \code{\link[crul]{HttpClient}}.
