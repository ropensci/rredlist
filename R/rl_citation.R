#' Get the citation for the Red List API
#'
#' Full acknowledgement and citation needs to be given for using the API. Use
#' this function to get the full citation for the current version of the Red
#' List API. More details are available here: <https://api.iucnredlist.org/>.
#'
#' @export
#' @param key (character) An IUCN API token. See [rl_use_iucn()].
#' @param ... Curl options passed to [HttpClient][crul::HttpClient()].
#' @return Red List citation as a [bibentry][utils::bibentry()] object.
#' @importFrom utils bibentry
#' @family stats
#' @examples \dontrun{
#' rl_citation()
#' }
rl_citation <- function(key = NULL, ...) {
  vers <- rl_version(key, ...)
  year <- strsplit(vers, "-")[[1]][1]
  cit <- bibentry(
    bibtype      = "Misc",
    key          = paste0("IUCN", year),
    author       = "IUCN",
    title        = "IUCN Red List of Threatened Species",
    year         = year,
    edition      = paste("Version", vers),
    howpublished = "\\url{https://www.iucnredlist.org}",
    note         = paste("Accessed on", format(Sys.Date(),"%d %B %Y")),
  )
  class(cit) <- c("citation", "bibentry")
  attr(cit, "mheader") <- "To cite the IUCN API in publications, use the
                           following citation:"
  return(cit)
}
