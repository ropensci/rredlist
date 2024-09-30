#' Get count of species in the Red List
#'
#' Returns a count of the number of unique species which have assessments
#'
#' @export
#' @param key (character) An IUCN API token. See \code{\link{rl_use_iucn}}.
#' @param ... Curl options passed to \code{\link[crul]{HttpClient}}
#' @template info
#' @family stats
#' @examples \dontrun{
#' # Get count of species with assessments
#' rl_sp_count()
#' }
rl_sp_count <- function(key = NULL, ...) {
  rl_parse(rl_sp_count_(key, ...), TRUE)$count
}

#' @export
#' @rdname rl_sp_count
rl_sp_count_ <- function(key = NULL, ...) {
  assert_is(key, "character")
  rr_GET("statistics/count", key, ...)
}
