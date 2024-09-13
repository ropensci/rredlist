#' Get count of species in the Red List
#'
#' Returns a count of the number of unique species which have assessments
#'
#' @export
#' @template all
#' @template info_new
#' @family stats
#' @examples \dontrun{
#' rl_sp_count()
#' }
rl_sp_count <- function(key = NULL, ...) {
  rl_parse(rl_sp_count_(key, ...), TRUE)$count
}

#' @export
#' @rdname rl_sp_count
rl_sp_count_ <- function(key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET("statistics/count", key, ...)
}
