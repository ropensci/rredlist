#' Population trend assessment summary
#'
#' Return a list of the latest assessments based on a population trend (i.e.
#' increasing, decreasing, stable or unknown).
#'
#' @export
#' @param code (character) The code of the growth form to look up. If not
#'   supplied, a list of all growth forms will be returned.
#' @template all
#' @template info
#' @template page
#' @examples \dontrun{
#' # Get list of all population trends
#' rl_pop_trends()
#' # Get assessment summary for stable population trends
#' rl_pop_trends("2")
#' }
rl_pop_trends <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                          page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_pop_trends_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_pop_trends
rl_pop_trends_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                           quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("population_trends", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
