#' @param ...  Includes the following arguments related to the wait time between
#'   request retries if a "Too Many Requests" error is received from the API
#'   (see [HttpClient()$retry()][crul::HttpClient()] for more details):
#'   \itemize{
#'     \item `pause_base`, `pause_cap`, and `pause_min`: basis, maximum, and minimum
#'       for calculating wait time for retry
#'     \item `times`: the maximum number of times to retry
#'     \item `onwait`: a callback function if the request will be retried and a
#'       wait time is being applied
#'   }
#'   Also supports any [curl options][curl::curl_options()] passed to the GET
#'   request via [HttpClient][crul::HttpClient()].
