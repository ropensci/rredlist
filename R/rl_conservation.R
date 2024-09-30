#' Conservation actions needed assessment summary
#'
#' Return the latest assessments with a given conservation action needed (e.g.,
#' Land/water management or Species recovery). These conservation action codes
#' correspond to the IUCN Red List Conservation Actions Classification Scheme
#' (v2.0).
#'
#' @export
#' @param code (character) The code of the conservation action to look up. If
#'   not supplied, a list of all conservation actions will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family conservation
#' @examples \dontrun{
#' # Get list of all conservation actions
#' rl_actions()
#' # Get assessments with Species recovery conservation action needed
#' rl_actions("3_2")
#' }
rl_actions <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                       page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_actions_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_actions
rl_actions_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                        quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("conservation_actions", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Research needed assessment summary
#'
#' Return the latest assessments with a given research needed (e.g., Taxonomy or
#' Population trends). These research codes correspond to the IUCN Red List
#' Research Needed Classification Scheme (v1.0).
#'
#' @export
#' @param code (character) The code of the research type to look up. If not
#'   supplied, a list of all research types will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family conservation
#' @examples \dontrun{
#' # Get list of all research types
#' rl_research()
#' # Get assessments with Taxonomy research needed
#' rl_research("1_1")
#' }
rl_research <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                        page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_research_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_research
rl_research_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                         quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("research", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
