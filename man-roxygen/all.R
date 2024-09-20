#' @param key (character) An IUCN API token. See \code{\link{rl_use_iucn}}.
#' @param ... Curl options passed to \code{\link[crul]{HttpClient}}. Also
#'   includes the following arguments that are supported by most of the API
#'   endpoints which return lists of assessments (refer to the [API
#'   docs](https://api.iucnredlist.org/api-docs/index.html) for more
#'   information):
#'   \itemize{
#'     \item \code{year_published}: (integer) Set this to return only
#'       assessments from a given year.
#'     \item \code{latest}: (logical) Set this to \code{TRUE} to return only the
#'       latest assessment for each taxon.
#'     \item \code{scope_code}: (integer) Set this to return only assessments
#'       from a particular scope (e.g., Global, Europe).
#'   }
#' @param parse (logical) Whether to parse the output to list (\code{FALSE}) or,
#'   where possible, data.frame (\code{TRUE}). Default: \code{TRUE}
