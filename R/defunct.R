# nocov start

#' Get common names for a given taxonomic name
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_species_latest()]`$taxon$common_names` as of **rredlist** version
#'   1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_common_names <- function(name = NULL, key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_common_names()",
    details = "Please use `rl_species_latest()$taxon$common_names` instead")
}

#' @export
#' @rdname rl_common_names
#' @usage NULL
rl_common_names_ <- function(name = NULL, key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_common_names_()",
                            "rl_species_latest_()")
}

#' Get historical assessments by taxon name, IUCN id, and region
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of [rl_species()] as of
#'   **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_history <- function(name = NULL, id = NULL, region = NULL,
                       key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_history()", "rl_species()")
}

#' @export
#' @rdname rl_history
#' @usage NULL
rl_history_ <- function(name = NULL, id = NULL, region = NULL,
                        key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_history()", "rl_species_()")
}

#' Get species conservation measures by taxon name, IUCN id, and region
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_species_latest()]`$conservation_actions` as of **rredlist** version
#'   1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_measures <- function(name = NULL, id = NULL, region = NULL,
                        key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_measures()",
    details = "Please use `rl_species_latest()$conservation_actions` instead")
}

#' @export
#' @rdname rl_measures
#' @usage NULL
rl_measures_ <- function(name = NULL, id = NULL, region = NULL,
                         key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_measures_()", "rl_species_latest_()")
}

#' Get species narrative information by taxon name, IUCN id, and region
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_species_latest()]`$documentation` as of **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_narrative <- function(name = NULL, id = NULL, region = NULL,
                         key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_narrative()",
    details = "Please use `rl_species_latest()$documentation` instead")
}

#' @export
#' @rdname rl_narrative
#' @usage NULL
rl_narrative_ <- function(name = NULL, id = NULL, region = NULL,
                          key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_narrative_()", "rl_species_latest_()")
}

#' Get country occurrence by species name or ID
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_species_latest()]`$locations` as of **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_occ_country <- function(name = NULL, id = NULL, region = NULL,
                           key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_occ_country()",
    details = "Please use `rl_species_latest()$locations` instead")
}

#' @export
#' @rdname rl_occ_country
#' @usage NULL
rl_occ_country_ <- function(name = NULL, id = NULL, region = NULL,
                            key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_occ_country_()",
                            "rl_species_latest_()")
}

#' Get regions
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_scopes(code = NULL)][rl_scopes()] as of **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_regions <- function(key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_regions()",
    details = "Please use `rl_scopes(code = NULL)` instead")
}

#' @export
#' @rdname rl_regions
#' @usage NULL
rl_regions_ <- function(key = NULL, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_regions_()",
    details = "Please use `rl_scopes_(code = NULL)` instead")
}

#' Search by taxon name, IUCN id, and region
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of [rl_species()], [rl_sis()],
#'   and [rl_scopes()] as of **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_search <- function(name = NULL, id = NULL, region = NULL,
                      key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_search()",
    details = "Please use `rl_species()`, `rl_sis()`, or `rl_scopes()` instead")
}

#' @export
#' @rdname rl_search
#' @usage NULL
rl_search_ <- function(name = NULL, id = NULL, region = NULL,
                       key = NULL, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_search_()",
    details = paste("Please use `rl_species_()`, `rl_sis_()`,",
                    "or `rl_scopes_()` instead"))
}

#' Get species
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of [rl_kingdom()],
#'   [rl_phylum()], [rl_class()], [rl_order()], and [rl_family()] as of
#'   **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_sp <- function(page = 0, key = NULL, parse = TRUE, all = FALSE,
                  quiet = FALSE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_sp()",
    details = paste("Please use `rl_kingdom()`, `rl_phylum()`,",
                    "`rl_class()`, `rl_order()`, or `rl_family()` instead"))
}

#' @export
#' @rdname rl_sp
#' @usage NULL
rl_sp_ <- function(page, key = NULL, all = FALSE, quiet = FALSE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_sp_()",
    details = paste("Please use `rl_kingdom_()`, `rl_phylum_()`,",
                    "`rl_class_()`, `rl_order_()`, or `rl_family_()` instead"))
}

#' Get species by category
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of [rl_categories()] as of
#'   **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_sp_category <- function(category, key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_sp_category()", "rl_categories()")
}

#' @export
#' @rdname rl_sp_category
#' @usage NULL
rl_sp_category_ <- function(category, key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_sp_category_()", "rl_categories_()")
}

#' Get citations by taxon name, IUCN id, and region
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_species_latest()]`$citation` as of **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_sp_citation <- function(name = NULL, id = NULL, region = NULL,
                           key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_sp_citation()",
    details = "Please use `rl_species_latest()$citation` instead")
}

#' @export
#' @rdname rl_sp_citation
#' @usage NULL
rl_sp_citation_ <- function(name = NULL, id = NULL, region = NULL,
                            key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_sp_citation_()",
                            "rl_species_latest_()")
}

#' Get species by country
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of [rl_countries()] as of
#'   **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_sp_country <- function(country, key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_sp_country()", "rl_countries()")
}

#' @export
#' @rdname rl_sp_country
#' @usage NULL
rl_sp_country_ <- function(country, key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_sp_country_()", "rl_countries_()")
}

#' Get species synonym information by taxonomic name
#'
#' @description `r lifecycle::badge('deprecated')`
#'
#'   This function is fully deprecated in favor of
#'   [rl_species_latest()]`$taxon$synonyms` as of **rredlist** version 1.0.0.
#' @keywords internal
#' @export
#' @usage NULL
rl_synonyms <- function(name = NULL, key = NULL, parse = TRUE, ...) {
  lifecycle::deprecate_stop(
    "1.0.0", "rl_synonyms()",
    details = "Please use `rl_species_latest()$taxon$synonyms` instead")
}

#' @export
#' @rdname rl_synonyms
#' @usage NULL
rl_synonyms_ <- function(name = NULL, key = NULL, ...) {
  lifecycle::deprecate_stop("1.0.0", "rl_synonyms_()",
                            "rl_species_latest()")
}
# nocov end
