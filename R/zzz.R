ct <- function(l) Filter(Negate(is.null), l)

rr_GET <- function(path, key, ...){
  temp <- GET(file.path(rr_base(), path), query = ct(list(token = check_key(key))), ...)
  stop_for_status(temp)
  stopifnot(temp$headers$`content-type` == 'application/json; charset=utf-8')
  err_catcher(temp)
  content(temp, as = 'text', encoding = "UTF-8")
}

err_catcher <- function(x) {
  xx <- content(x)
  if (any(vapply(c("message", "error"), function(z) z %in% names(xx), logical(1)))) {
    stop(xx[[1]], call. = FALSE)
  }
}

rl_parse <- function(x, parse) {
  jsonlite::fromJSON(x, parse)
}

check_key <- function(x){
  tmp <- if (is.null(x)) Sys.getenv("IUCN_REDLIST_KEY", "") else x
  if (tmp == "") {
    getOption("iucn_redlist_key", stop("need an API key for NOAA data", call. = FALSE))
  } else {
    tmp
  }
}

rr_base <- function() "http://apiv3.iucnredlist.org/api/v3"
