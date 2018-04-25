#' Get species
#'
#' @export
#' @param page (integer/numeric) Page to get. Default: 0. you can 
#' get up to 10,000 records per page. Paging is required because
#' it's too much burden on a server to just "get all the data"
#' in one request
#' @param all (logical) to get all results or not. Default: `FALSE`. 
#' this means we do the paging internally for you. result is a list
#' of results, so you have to bind them together yourself into 
#' a data.frame, see example
#' @param quiet (logical) give progress for download or not. 
#' Default: `FALSE` (that is, give progress). ignored if 
#' `all = FALSE` 
#' @template all
#' @examples \dontrun{
#' rl_sp(page = 3)
#' 
#' # get all results
#' out <- rl_sp(all = TRUE)
#' length(out)
#' vapply(out, "[[", 1, "count")
#' all_df <- do.call(rbind, lapply(out, "[[", "result"))
#' head(all_df)
#' NROW(all_df)
#' }
rl_sp <- function(page = 0, key = NULL, parse = TRUE, all = FALSE, 
  quiet = FALSE, ...) {

  assert_is(parse, 'logical')
  assert_is(all, 'logical')

  res <- rl_sp_(page, key, all, quiet, ...)
  if (all) lapply(res, rl_parse, parse = parse) else rl_parse(res, parse)
}

#' @export
#' @rdname rl_sp
rl_sp_ <- function(page, key = NULL, all = FALSE, quiet = FALSE, ...) {
  assert_is(key, 'character')
  assert_is(page, c('integer', 'numeric'))
  assert_n(page, 1)
  
  if (all) {
    out <- list()
    done <- FALSE
    i <- 0
    page <- 0
    while (!done) {
      if (!quiet) cat(".")
      i <- i + 1
      tmp <- rr_GET(file.path("species/page", page), key, ...)
      if (jsonlite::fromJSON(tmp, FALSE)$count == 0) {
        done <- TRUE
      } else {
        out[[i]] <- tmp
        page <- page + 1
      }
    }
    if (!quiet) cat("\n")
    return(out)
  } else {
    rr_GET(file.path("species/page", page), key, ...)
  }
}
