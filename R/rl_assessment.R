#' Retrieve an assessment
#'
#' Get the full details for a single IUCN Red List assessment
#'
#' @export
#' @param id (integer) The unique identifier of the assessment.
#' @template all
#' @template info
#' @examples \dontrun{
#' # Get assessment details for Fratercula arctica
#' ex1 <- rl_assessment(id = 166290968)
#' ex1$red_list_category$code
#' ex1$systems
#' }
rl_assessment <- function(id, key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  rl_parse(rl_assessment_(id, key, ...), parse)
}

#' @export
#' @rdname rl_assessment
rl_assessment_ <- function(id, key = NULL, ...) {
  assert_is(key, "character")
  assert_is(id, c("integer", "numeric"))
  assert_n(id, 1)

  rr_GET(paste0("assessment/", id), key, ...)
}
