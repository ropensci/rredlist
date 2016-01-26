#' Get the citation Red List API version
#'
#' @export
#' @param key A IUCN API token
#' @param ... Curl options passed to \code{\link[httr]{GET}}
#' @return API citation as character string
#' @examples \dontrun{
#' rl_citation()
#' }
rl_citation <- function(key = NULL, ...) {
  sprintf('IUCN 2015. IUCN Red List of Threatened Species. Version %s <www.iucnredlist.org>',
          rl_version(key, ...))
}
