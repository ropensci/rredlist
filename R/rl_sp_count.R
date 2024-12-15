#' Get count of species in the Red List
#'
#' Returns a count of the number of unique species which have assessments.
#'
#' @export
#' @param key (character) An IUCN API token. See [rl_use_iucn()].
#' @param ... Curl options passed to [HttpClient][crul::HttpClient()]
#' @return An integer representing the number of unique species represented
#'   within the IUCN database.
#' @references API docs at <https://api.iucnredlist.org/>.
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
