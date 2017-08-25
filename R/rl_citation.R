#' Get the citation Red List API version
#'
#' @export
#' @param ... Curl options passed to [crul::HttpClient()]
#' @return API citation as character string
#' @examples \dontrun{
#' rl_citation()
#' }
rl_citation <- function(...) {
  sprintf('IUCN 2015. IUCN Red List of Threatened Species. Version %s <www.iucnredlist.org>',
          rl_version(...))
}
