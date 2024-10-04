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
#' @return Invisibly returns the sign-up URL for the IUCN Red List API.
#' @importFrom utils browseURL
#' @examples \dontrun{
#' # Sign up for an API key
#' rl_use_iucn()
#' }
rl_use_iucn <- function() {
  if (interactive()) {
    browseURL("https://api.iucnredlist.org/users/sign_up")
  }

  message(paste0("After getting your key set it as IUCN_REDLIST_KEY in",
                 " .Renviron.\n IUCN_REDLIST_KEY='youractualkeynotthisstring'",
                 "\n For that, use usethis::edit_r_environ()"))

  invisible("https://api.iucnredlist.org/users/sign_up")
}
