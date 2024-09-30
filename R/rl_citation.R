#' Get the citation for the Red List API
#'
#' Full acknowledgement and citation needs to be given for using the API. Use
#' this function to get the full citation for the current version of the Red
#' List API. More details are available here: <https://api.iucnredlist.org/>.
#'
#' @export
#' @param key (character) An IUCN API token. See \code{\link{rl_use_iucn}}.
#' @param ... Curl options passed to \code{\link[crul]{HttpClient}}
#' @return Red List citation as character string
#' @family stats
#' @examples \dontrun{
#' rl_citation()
#' }
rl_citation <- function(key = NULL, ...) {
  paste("IUCN 2024. IUCN Red List of Threatened Species. Version",
        rl_version(key, ...), "<www.iucnredlist.org>")
}
