#' Helper to get and save IUCN API key
#'
#' @description Provides instruction on how to get and store a key for the IUCN
#'   API. Users of `rredlist` must do this before using any of the package's
#'   other functionality. Note that registering for a key requires an email
#'   address and information about your organization.
#'
#' @details Note that after filling the online form, you should receive an API
#'   key shortly but not immediately.
#'
#' @aliases rl_key
#'
#' @export
#' @return Invisibly returns the sign-up URL for the IUCN Red List API.
#' @importFrom cli cli_h2 cli_ol cli_li cli_code cli_end
#' @examples \dontrun{
#' # Sign up for an API key
#' rl_use_iucn()
#' }
rl_use_iucn <- function() {
  cli_h2("To get and save an IUCN API key, follow these steps:")
  cli_ol()
  cli_li("Register for an API key on the {.href [IUCN website](https://api.iucnredlist.org/users/sign_up)} (requires an email address and organization info)")
  cli_li("Run {.run usethis::edit_r_environ()} to open and edit your .Renviron file")
  cli_li("Add the following text to your .Renviron file, inserting your own API key value:")
  cli_code("     IUCN_REDLIST_KEY='youractualkeynotthisstring'")
  cli_li("Restart R")
  cli_end()

  invisible("https://api.iucnredlist.org/users/sign_up")
}
