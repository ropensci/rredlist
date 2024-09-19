#' Comprehensive group assessment summary
#'
#' Returns a list of the latest assessments for an comprehensive group name
#'
#' @export
#' @param name (character) The code of the comprehensive group to look up. If
#'   not supplied, a list of all comprehensive groups will be returned.
#' @template all
#' @template info
#' @template page
#' @examples \dontrun{
#' # Get list of all comprehensive groups
#' rl_comp_groups()
#' # Get assessment summary for sea snakes
#' rl_comp_groups('seasnakes')
#' }
rl_comp_groups <- function(name = NULL, key = NULL, parse = TRUE, all = TRUE,
                           page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_comp_groups_(name, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_comp_groups
rl_comp_groups_ <- function(name = NULL, key = NULL, all = TRUE, page = 1,
                            quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(name, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("comprehensive_groups", name, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
