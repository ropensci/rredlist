ct <- function(l) Filter(Negate(is.null), l)

rr_GET <- function(path, key, ...){
  cli <- HttpClient$new(url = file.path(rr_base(), path), opts = list(...))
  temp <- cli$get(query = list(token = check_key(key)))
  if (temp$status_code > 201) {
    stop(sprintf("(%s) - %s", temp$status_code, temp$status_http()$message), call. = FALSE)
  }
  err_catcher(temp)
  temp$parse()
}

err_catcher <- function(x) {
  xx <- jsonlite::fromJSON(x$parse())
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
    getOption("iucn_redlist_key", stop("need an API key for Red List data", call. = FALSE))
  } else {
    tmp
  }
}

rr_base <- function() "http://apiv3.iucnredlist.org/api/v3"

space <- function(x) gsub("\\s", "%20", x)
