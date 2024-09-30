#' SIS ID assessment summary
#'
#' Get an assessment summary for a particular taxonomic entity based on its ID
#' number from the [IUCN Species Information Service
#' (SIS)](https://www.iucnredlist.org/assessment/sis).
#'
#' @export
#' @param id (integer) The SIS ID of the taxonomic entity to look up.
#' @template all
#' @template curl
#' @template info
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for species
#' ex1 <- rl_sis(id = 9404)
#' nrow(ex1$assessments)
#' }
rl_sis <- function(id, key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  rl_parse(rl_sis_(id, key, ...), parse)
}

#' @export
#' @rdname rl_sis
rl_sis_ <- function(id, key = NULL, ...) {
  assert_is(key, "character")
  assert_is(id, c("integer", "numeric"))

  rr_GET(paste("taxa/sis", id, sep = "/"), key, ...)
}

#' SIS ID latest assessment
#'
#' Get the latest assessment for a particular taxonomic entity based on its ID
#' number from the [IUCN Species Information Service
#' (SIS)](https://www.iucnredlist.org/assessment/sis). Wraps [rl_sis()] and
#' [rl_assessment()].
#'
#' @export
#' @param id (integer) The SIS ID of the taxonomic entity to look up.
#' @template all
#' @template curl
#' @template info
#' @family taxa
#' @examples \dontrun{
#' # Get latest assessment for species
#' ex1 <- rl_sis_latest(id = 9404)
#' ex1$stresses
#' }
rl_sis_latest <- function(id, key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  tmp <- rl_sis(id, key, ...)$assessments
  if (any(tmp$latest, na.rm = TRUE)) {
    tmp_sub <- subset(tmp, tmp$latest)
  }
  tmp_sub$year_published <- as.numeric(as.character(tmp_sub$year_published))
  ord <- order(tmp_sub$year_published, decreasing = TRUE)
  tmp_sub <- tmp_sub[ord, , drop = FALSE]
  rl_assessment(id = tmp_sub$assessment_id[1], key = key, parse = parse, ...)
}

#' Species assessment summary
#'
#' Get an assessment summary for a particular species (i.e., Latin binomial) or
#' subspecies/variety/subpopulation (i.e., Latin trinomial).
#'
#' @export
#' @param genus (character) The genus name of the species to look up.
#' @param species (character) The species epithet of the species to look up.
#' @param infra (character) An optional name of the subspecies or variety to
#'   look up.
#' @param subpopulation (character) An optional name of the geographically
#'   separate subpopulation to look up.
#' @details Geographically separate subpopulations of a species are defined as
#'   those populations that are so isolated from others of the same species that
#'   it is considered extremely unlikely that there is any genetic interchange.
#'   In general, listings of such subpopulations are restricted to those that
#'   have been isolated for a long period of time.
#'
#'   Assessments of subspecies, varieties, and geographically separate
#'   subpopulations must adhere to the same standards as for species
#'   assessments. However, these assessments are only included provided there is
#'   a global assessment of the species as a whole.
#'
#'   Infraspecific ranks such as formas, subvarieties, cultivars, etc are not
#'   included in the Red List.
#' @template all
#' @template curl
#' @template info
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for species
#' ex1 <- rl_species(genus = "Fratercula", species = "arctica")
#' nrow(ex1$assessments)
#'
#' # Get assessment summary for subspecies
#' ex2 <- rl_species(genus = "Gorilla", species = "gorilla",
#'                   infra = "gorilla")
#' nrow(ex2$assessments)
#' }
rl_species <- function(genus, species, infra = NULL, subpopulation = NULL,
                       key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  rl_parse(rl_species_(genus, species, infra, subpopulation, key, ...), parse)
}

#' @export
#' @rdname rl_species
rl_species_ <- function(genus, species, infra = NULL, subpopulation = NULL,
                        key = NULL, ...) {
  assert_is(key, "character")
  assert_is(genus, "character")
  assert_is(species, "character")
  assert_is(infra, "character")
  assert_is(subpopulation, "character")

  rr_GET("taxa/scientific_name", key,
         query = list(genus_name = genus, species_name = species,
                      infra_name = infra, subpopulation_name = subpopulation),
         ...)
}

#' Species latest assessment
#'
#' Get the latest assessment for a particular species (i.e., Latin binomial) or
#' subspecies/variety/subpopulation (i.e., Latin trinomial). Wraps
#' [rl_species()] and [rl_assessment()].
#'
#' @export
#' @param genus (character) The genus name of the species to look up.
#' @param species (character) The species epithet of the species to look up.
#' @param infra (character) An optional name of the subspecies or variety to
#'   look up.
#' @param subpopulation (character) An optional name of the geographically
#'   separate subpopulation to look up.
#' @details Geographically separate subpopulations of a species are defined as
#'   those populations that are so isolated from others of the same species that
#'   it is considered extremely unlikely that there is any genetic interchange.
#'   In general, listings of such subpopulations are restricted to those that
#'   have been isolated for a long period of time.
#'
#'   Assessments of subspecies, varieties, and geographically separate
#'   subpopulations must adhere to the same standards as for species
#'   assessments. However, these assessments are only included provided there is
#'   a global assessment of the species as a whole.
#'
#'   Infraspecific ranks such as formas, subvarieties, cultivars, etc are not
#'   included in the Red List.
#' @template all
#' @template curl
#' @template info
#' @family taxa
#' @examples \dontrun{
#' # Get latest assessment for species
#' ex1 <- rl_species_latest(genus = "Fratercula", species = "arctica")
#' ex1$stresses
#'
#' # Get latest assessment for subspecies
#' ex2 <- rl_species_latest(genus = "Gorilla", species = "gorilla",
#'                          infra = "gorilla")
#' ex2$stresses
#' }
rl_species_latest <- function(genus, species, infra = NULL,
                              subpopulation = NULL,
                              key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  tmp <- rl_species(genus, species, infra = infra,
                    subpopulation = subpopulation, key, ...)$assessments
  if (any(tmp$latest, na.rm = TRUE)) {
    tmp_sub <- subset(tmp, tmp$latest)
  }
  tmp_sub$year_published <- as.numeric(as.character(tmp_sub$year_published))
  ord <- order(tmp_sub$year_published, decreasing = TRUE)
  tmp_sub <- tmp_sub[ord, , drop = FALSE]
  rl_assessment(id = tmp_sub$assessment_id[1], key = key, parse = parse, ...)
}

#' Family assessment summary
#'
#' Get an assessment summary for a particular family
#'
#' @export
#' @param family (character) The name of the family to look up. If not supplied,
#'   a list of all family names will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for family
#' ex1 <- rl_family(family = "Hominidae")
#' nrow(ex1$assessments)
#' }
rl_family <- function(family = NULL, key = NULL, parse = TRUE, all = TRUE,
                      page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_family_(family, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_family
rl_family_ <- function(family = NULL, key = NULL, all = TRUE, page = 1,
                       quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(family, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("taxa/family", family, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Order assessment summary
#'
#' Get an assessment summary for a particular order
#'
#' @export
#' @param order (character) The name of the order to look up. If not supplied, a
#'   list of all order names will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for order
#' ex1 <- rl_order(order = "Apiales")
#' nrow(ex1$assessments)
#' }
rl_order <- function(order = NULL, key = NULL, parse = TRUE, all = TRUE,
                     page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_order_(order, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_order
rl_order_ <- function(order = NULL, key = NULL, all = TRUE, page = 1,
                      quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(order, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("taxa/order", order, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Class assessment summary
#'
#' Get an assessment summary for a particular class
#'
#' @export
#' @param class (character) The name of the class to look up. If not supplied, a
#'   list of all class names will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for class
#' ex1 <- rl_class(class = "Mammalia")
#' nrow(ex1$assessments)
#' }
rl_class <- function(class = NULL, key = NULL, parse = TRUE, all = TRUE,
                     page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_class_(class, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_class
rl_class_ <- function(class = NULL, key = NULL, all = TRUE, page = 1,
                      quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(class, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("taxa/class", class, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Phylum assessment summary
#'
#' Get an assessment summary for a particular phylum
#'
#' @export
#' @param phylum (character) The name of the phylum to look up. If not supplied,
#'   a list of all phylum names will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for phylum
#' ex1 <- rl_phylum(phylum = "Annelida`")
#' nrow(ex1$assessments)
#' }
rl_phylum <- function(phylum = NULL, key = NULL, parse = TRUE, all = TRUE,
                      page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_phylum_(phylum, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_phylum
rl_phylum_ <- function(phylum = NULL, key = NULL, all = TRUE, page = 1,
                       quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(phylum, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("taxa/phylum", phylum, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Kingdom assessment summary
#'
#' Get an assessment summary for a particular kingdom
#'
#' @export
#' @param kingdom (character) The name of the kingdom to look up. If not
#'   supplied, a list of all kingdom names will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' # Get assessment summary for kingdom
#' ex1 <- rl_kingdom(kingdom = "Fungi")
#' nrow(ex1$assessments)
#' }
rl_kingdom <- function(kingdom = NULL, key = NULL, parse = TRUE, all = TRUE,
                       page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_kingdom_(kingdom, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_kingdom
rl_kingdom_ <- function(kingdom = NULL, key = NULL, all = TRUE, page = 1,
                        quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(kingdom, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("taxa/kingdom", kingdom, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Extinct taxa assessment summary
#'
#' Get an assessment summary for all possibly extinct taxa
#'
#' @export
#' @template all
#' @template curl
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' ex1 <- rl_extinct()
#' nrow(ex1$assessments)
#' }
rl_extinct <- function(key = NULL, parse = TRUE, all = TRUE, page = 1,
                       quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_extinct_(key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_extinct
rl_extinct_ <- function(key = NULL, all = TRUE, page = 1, quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- "taxa/possibly_extinct"
  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Extinct taxa in the wild assessment summary
#'
#' Get an assessment summary for all taxa that are possibly extinct in the wild
#'
#' @export
#' @template all
#' @template curl
#' @template info
#' @template page
#' @family taxa
#' @examples \dontrun{
#' ex1 <- rl_extinct_wild()
#' nrow(ex1$assessments)
#' }
rl_extinct_wild <- function(key = NULL, parse = TRUE, all = TRUE, page = 1,
                            quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_extinct_wild_(key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_extinct_wild
rl_extinct_wild_ <- function(key = NULL, all = TRUE, page = 1,
                             quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- "taxa/possibly_extinct_in_the_wild"
  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
