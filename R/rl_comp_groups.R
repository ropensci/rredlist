#' Information about comprehensive groups
#'
#' @export
#' @param group (character) A comprehensive group name. 
#' Call `rl_comp_groups()` without passing this parameter
#' to get the list of comprehensive groups
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_comp_groups()
#' rl_comp_groups('mammals')
#' rl_comp_groups('groupers')
#'
#' rl_comp_groups_()
#' rl_comp_groups_('groupers')
#' }
rl_comp_groups <- function(group = NULL, key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_comp_groups_(group, key, ...), parse)
}

#' @export
#' @rdname rl_comp_groups
rl_comp_groups_ <- function(group = NULL, key = NULL, ...) {
  assert_is(key, 'character')
  assert_is(group, 'character')

  path <- "comp-group/list"
  if (!is.null(group)) path <- file.path("comp-group/getspecies", group)
  rr_GET(path, key, ...)
}
