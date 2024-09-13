#' Get the Red List API version
#'
#' Returns the current version number of the IUCN Red List of Threatened Species
#' API
#'
#' @export
#' @param key (character) An IUCN API token. See \code{\link{rl_use_iucn}}.
#' @param ... Curl options passed to \code{\link[crul]{HttpClient}}
#' @return API version as character string
#' @family stats
#' @examples \dontrun{
#' rl_api_version()
#' }
rl_api_version <- function(key = NULL, ...) {
  assert_is(key, 'character')
  rl_parse(rr_GET("information/api_version", key, ...), TRUE)$api_version
}

#' Get the Red List version
#'
#' Returns the current version number of the IUCN Red List of Threatened Species
#'
#' @export
#' @param key (character) An IUCN API token. See \code{\link{rl_use_iucn}}.
#' @param ... Curl options passed to \code{\link[crul]{HttpClient}}
#' @return Red List version as character string
#' @family stats
#' @examples \dontrun{
#' rl_version()
#' }
rl_version <- function(key = NULL, ...) {
  assert_is(key, 'character')
  rl_parse(rr_GET("information/red_list_version", key, ...),
           TRUE)$red_list_version
}
