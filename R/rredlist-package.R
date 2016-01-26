#' rredlist - IUCN Red List Client
#'
#' @section Authentication:
#' IUCN requires you to get your own API key, an alphanumeric string that you
#' need to send in every request. Get it at \url{http://apiv3.iucnredlist.org/api/v3/token}.
#' Keep this key private. You can pass the key in to each function via the
#' \code{key} parameter, but it's better to store the key either as a environment
#' variable (\code{IUCN_REDLIST_KEY}) or an R option (\code{iucn_redlist_key}) - we
#' suggest using the former option.
#'
#' @section High vs. Low level package APIs:
#' \strong{High level API}
#' High level functions do the HTTP request and parse data to a data.frame for
#' ease of downstream use. The high level functions have no underscore on the end
#' of the function name, e.g., \code{\link{rl_search}}
#'
#' \strong{Low level API}
#' The parsing to data.frame in the high level API does take extra time. The low
#' level API only does the HTTP request, and gives back JSON without doing any
#' more parsing. The low level functions DO have an underscore on the end
#' of the function name, e.g., \code{\link{rl_search_}}
#'
#' @section No Spatial:
#' This package does not include support for the spatial API, described at
#' \url{http://apiv3.iucnredlist.org/spatial}
#'
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @name rredlist-package
#' @aliases rredlist
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL
