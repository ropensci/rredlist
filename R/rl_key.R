#' Helper to get and save IUCN API key
#'
#' @description Browse IUCN Red List API key request URL and
#'  provides instruction on how to store the key.
#'
#' @details Note that after filling the online form, you should
#'   receive an API key shortly but not immediately.
#'
#' @aliases rl_use_iucn
#'
#' @export
#'
rl_use_iucn <- function(){
  if(interactive()){
    utils::browseURL("http://apiv3.iucnredlist.org/api/v3/token")
  }

  message("After getting your key set it as IUCN_REDLIST_KEY in .Renviron.\n IUCN_REDLIST_KEY='youractualkeynotthisstring'\n For that, use usethis::edit_r_environ()")

  invisible("http://apiv3.iucnredlist.org/api/v3/token")
}