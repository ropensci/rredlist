#' @param all (logical) Whether to retrieve all results at once or not. If
#'   `TRUE` we do the paging internally for you and bind all of the results
#'   together. If `FALSE`, only a single page of results will be retrieved.
#' @param page (integer/numeric) Page to get if `all` is `FALSE`. Default: 1.
#'   Each page returns up to 100 records. Paging is required because it's too
#'   much burden on a server to just "get all the data" in one request.
#' @param quiet (logical) Whether to give progress for download or not. Default:
#'   `FALSE` (that is, give progress). Ignored if `all = FALSE`.
