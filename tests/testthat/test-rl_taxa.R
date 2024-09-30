context("rl_taxa functions")

ranks <- c("kingdom", "phylum", "class", "order", "family")
names <- c("Chromista", "Porifera", "Hydrozoa", "Crocodylia", "Hominidae")

for (i in seq_along(ranks)) {
  rank <- ranks[i]
  name <- names[i]
  fn_name <- paste0("rl_", rank)
  fn_name_ <- paste0("rl_", rank, "_")
  fn <- get(fn_name)
  fn_ <- get(fn_name_)
  test_that("high level works - parsing", {
    skip_on_cran()

    vcr::use_cassette(paste0(fn_name, "-def"), {
      aa <- fn()
    })

    expect_is(aa, "list")
    expect_named(aa, c(paste0(rank, "_names")))
    expect_is(aa[[paste0(rank, "_names")]], "character")

    vcr::use_cassette(fn_name, {
      aa <- fn(name)
    })

    expect_is(aa, "list")
    expect_named(aa, c("assessments", "filters"))
    expect_is(aa$filters, "list")
    expect_is(aa$filters[[paste0(rank, "_name")]], "character")
    expect_equal(aa$filters[[paste0(rank, "_name")]], name)
    expect_is(aa$assessments, "data.frame")
  })

  test_that("high level works - not parsing", {
    skip_on_cran()

    vcr::use_cassette(paste0(fn_name, "-def-not-parsing"), {
      aa <- fn(parse = FALSE)
    })

    expect_is(aa, "list")
    expect_named(aa, c(paste0(rank, "_names")))
    expect_is(aa[[paste0(rank, "_names")]], "list")

    vcr::use_cassette(paste0(fn_name, "-not-parsing"), {
      aa <- fn(name, parse = FALSE)
    })

    expect_named(aa, c("assessments", "filters"))
    expect_is(aa$filters, "list")
    expect_is(aa$filters[[paste0(rank, "_name")]], "character")
    expect_equal(aa$filters[[paste0(rank, "_name")]], name)
    expect_is(aa$assessments, "list")
  })

  test_that("low level works", {
    skip_on_cran()

    library("jsonlite")

    vcr::use_cassette(paste0(fn_name_, "-def"), {
      aa <- fn_()
    })

    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c(paste0(rank, "_names")))
    expect_is(aajson[[paste0(rank, "_names")]], "character")

    vcr::use_cassette(paste0(fn_name, "_"), {
      aa <- fn_(name, all = FALSE)
    })

    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_named(aajson, c("assessments", "filters"))
    expect_is(aajson$filters, "list")
    expect_is(aajson$filters[[paste0(rank, "_name")]], "character")
    expect_equal(aajson$filters[[paste0(rank, "_name")]], name)
    expect_is(aajson$assessments, "data.frame")
  })

  test_that("fails well", {
    skip_on_cran()

    expect_error(fn(5), paste(rank, "must be of class character"))
    expect_error(fn(list()), paste(rank, "must be of class character"))

    expect_error(fn(key = 5), "key must be of class character")
    expect_error(fn(key = matrix()), "key must be of class character")

    expect_error(fn(parse = 5), "parse must be of class logical")
    expect_error(fn(parse = matrix()), "parse must be of class logical")

    expect_error(fn(page = "next"), "page must be of class integer")
    expect_error(fn(all = "yes"), "all must be of class logical")
    expect_error(fn(quiet = "no"), "quiet must be of class logical")

    # lengths
    expect_error(fn(page = 1:2), "page must be length 1")

  })
}
