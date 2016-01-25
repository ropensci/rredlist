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
