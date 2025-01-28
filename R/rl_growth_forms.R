#' Growth form assessment summary
#'
#' Returns a list of the latest assessments for a given growth form code.
#'
#' @export
#' @param code (character) The code of the growth form to look up. If not
#'   supplied, a list of all growth forms will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family groups
#' @examples \dontrun{
#' # Get list of all growth forms
#' rl_growth_forms()
#' # Get assessment summary for lichens
#' rl_growth_forms("LC")
#' }
rl_growth_forms <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                            page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_growth_forms_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_growth_forms
rl_growth_forms_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                             quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_n(code, 1)
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("growth_forms", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
