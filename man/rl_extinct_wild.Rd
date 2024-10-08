% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rl_taxa.R
\name{rl_extinct_wild}
\alias{rl_extinct_wild}
\alias{rl_extinct_wild_}
\title{Extinct taxa in the wild assessment summary}
\usage{
rl_extinct_wild(
  key = NULL,
  parse = TRUE,
  all = TRUE,
  page = 1,
  quiet = FALSE,
  ...
)

rl_extinct_wild_(key = NULL, all = TRUE, page = 1, quiet = FALSE, ...)
}
\arguments{
\item{key}{(character) An IUCN API token. See \code{\link{rl_use_iucn}}.}

\item{parse}{(logical) Whether to parse the output to list (\code{FALSE}) or,
where possible, data.frame (\code{TRUE}). Default: \code{TRUE}}

\item{all}{(logical) Whether to retrieve all results at once or not. If
\code{TRUE} we do the paging internally for you and bind all of the results
together. If \code{FALSE}, only a single page of results will be retrieved.}

\item{page}{(integer/numeric) Page to get if \code{all} is \code{FALSE}. Default: 1.
Each page returns up to 100 records. Paging is required because it's too
much burden on a server to just "get all the data" in one request.}

\item{quiet}{(logical) Whether to suppress progress for multi-page downloads
or not. Default: \code{FALSE} (that is, give progress). Ignored if \code{all = FALSE}.}

\item{...}{\link[curl:curl_options]{Curl options} passed to the GET request via
\code{\link[crul]{HttpClient}}.}
}
\value{
A list unless using a function with a trailing underscore, in which
case json as character string is returned.
}
\description{
Get an assessment summary for all taxa that are possibly extinct in the wild
}
\examples{
\dontrun{
ex1 <- rl_extinct_wild()
nrow(ex1$assessments)
}
}
\references{
API docs at \url{https://api.iucnredlist.org/}.
}
\seealso{
Assessments for specific sets of taxa
\code{\link{rl_comp_groups}()},
\code{\link{rl_extinct}()},
\code{\link{rl_green}()},
\code{\link{rl_growth_forms}()}
}
\concept{groups}
