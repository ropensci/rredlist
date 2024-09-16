#' Threat assessment summary
#'
#' Return a list of the latest assessments which are subject to a specific
#' threat (e.g., energy production and mining, climate change, and severe
#' weather). This will only return assessments for the threat code specified.
#' You will need to do additional requests for sub-threats (e.g., a request for
#' threat code 2_1 will need additional requests for codes 2_1_1, 2_1_2, etc.).
#'
#' @export
#' @param code (character) The code of the threat to look up. If not supplied, a
#'   list of all threats will be returned.
#' @template all
#' @template info
#' @template page
#' @family threats
#' @examples \dontrun{
#' # Get all threats
#' rl_threats()
#' # Get assessment summary for intentional hunting and trapping
#' rl_threats("5_1_1")
#' }
rl_threats <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                       page = 1, quiet = FALSE,...) {
  assert_is(parse, 'logical')
  assert_is(all, 'logical')

  res <- rl_threats_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_threats
rl_threats_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                        quiet = FALSE, ...) {
  assert_is(key, 'character')
  assert_is(code, 'character')
  assert_is(page, c('integer', 'numeric'))
  assert_n(page, 1)
  assert_is(all, 'logical')
  assert_is(quiet, 'logical')

  path <- paste("threats", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Stress assessment summary
#'
#' Return a list of the latest assessments based on the stresses species are
#' subject to (e.g., Ecosystem degradation, species disturbance, etc.).
#'
#' @export
#' @param code (character) The code of the stress to look up. If not supplied, a
#'   list of all stresses will be returned.
#' @template all
#' @template info
#' @template page
#' @family threats
#' @examples \dontrun{
#' # Get all stresses
#' rl_stresses()
#' # Get assessment summary for ecosystem degradation stress
#' rl_stresses("1_2")
#' }
rl_stresses <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                       page = 1, quiet = FALSE,...) {
  assert_is(parse, 'logical')
  assert_is(all, 'logical')

  res <- rl_stresses_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_stresses
rl_stresses_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                        quiet = FALSE, ...) {
  assert_is(key, 'character')
  assert_is(code, 'character')
  assert_is(page, c('integer', 'numeric'))
  assert_n(page, 1)
  assert_is(all, 'logical')
  assert_is(quiet, 'logical')

  path <- paste("stresses", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Use and trade assessment summary
#'
#' Return a list of the latest assessments which are subject to a specific use
#' and trade.
#'
#' @export
#' @param code (character) The code of the use and trade to look up. If not
#'   supplied, a list of all uses and trades will be returned.
#' @template all
#' @template info
#' @template page
#' @family threats
#' @examples \dontrun{
#' # Get all stresses
#' rl_use_and_trade()
#' # Get assessment summary for medicinal use and trade
#' rl_use_and_trade("3")
#' }
rl_use_and_trade <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                        page = 1, quiet = FALSE,...) {
  assert_is(parse, 'logical')
  assert_is(all, 'logical')

  res <- rl_use_and_trade_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_use_and_trade
rl_use_and_trade_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                         quiet = FALSE, ...) {
  assert_is(key, 'character')
  assert_is(code, 'character')
  assert_is(page, c('integer', 'numeric'))
  assert_n(page, 1)
  assert_is(all, 'logical')
  assert_is(quiet, 'logical')

  path <- paste("use_and_trade", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
