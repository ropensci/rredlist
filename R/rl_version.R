#' Get the Red List API version
#'
#' @export
#' @param key A IUCN API token
#' @param ... Curl options passed to \code{\link[httr]{GET}}
#' @return API version as character string
#' @examples \dontrun{
#' rl_version()
#' }
rl_version <- function(key = NULL, ...) {
  rl_parse(rr_GET("version", key, ...), TRUE)$version
}

rl_citation <- function(key = NULL, ...) {
  sprintf('IUCN 2015. IUCN Red List of Threatened Species. Version %s <www.iucnredlist.org>',
          rl_version(key, ...))
}
