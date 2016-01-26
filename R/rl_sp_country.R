#' Get species by country
#'
#' @export
#' @param country (character) Country 2 letter character code
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_sp_country('AZ')
#' rl_sp_country('NZ')
#'
#' # don't parse to data.frame, gives list
#' rl_sp_country('NZ', parse = FALSE)
#' # don't parse at all, get json back
#' rl_sp_country_('NZ')
#'
#' # curl options
#' library("httr")
#' res <- rl_sp_country('NZ', config=verbose())
#' }
rl_sp_country <- function(country, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_sp_country_(country, key, ...), parse)
}

#' @export
#' @rdname rl_sp_country
rl_sp_country_ <- function(country, key = NULL, ...) {
  rr_GET(file.path("country/getspecies", country), key, ...)
}
