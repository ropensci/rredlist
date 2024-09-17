context("rl_growth_forms functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_growth_forms-def", {
    aa <- rl_growth_forms()
  })

  expect_is(aa, "list")
  expect_named(aa, c("growth_forms"))
  expect_is(aa$growth_forms, "data.frame")

  vcr::use_cassette("rl_growth_forms", {
    aa <- rl_growth_forms('LC')
  })

  expect_is(aa, "list")
  expect_named(aa, c("growth_form", "assessments", "filters"))
  expect_is(aa$growth_form, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_growth_forms-def-not-parsing", {
    aa <- rl_growth_forms(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("growth_forms"))
  expect_is(aa$growth_forms, "list")

  vcr::use_cassette("rl_growth_forms-not-parsing", {
    aa <- rl_growth_forms('LC', parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("growth_form", "assessments", "filters"))
  expect_is(aa$growth_form, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_growth_forms_-def", {
    aa <- rl_growth_forms_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("growth_forms"))
  expect_is(aajson$growth_forms, "data.frame")

  vcr::use_cassette("rl_growth_forms_", {
    aa <- rl_growth_forms_('LC', all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("growth_form", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_growth_forms(5), "code must be of class character")
  expect_error(rl_growth_forms(list()), "code must be of class character")

  expect_error(rl_growth_forms(key = 5), "key must be of class character")
  expect_error(rl_growth_forms(key = matrix()), "key must be of class character")

  expect_error(rl_growth_forms(parse = 5), "parse must be of class logical")
  expect_error(rl_growth_forms(parse = matrix()), "parse must be of class logical")

  expect_error(rl_growth_forms(page = "next"), "page must be of class integer")
  expect_error(rl_growth_forms(all = "yes"), "all must be of class logical")
  expect_error(rl_growth_forms(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_growth_forms(page = 1:2), "page must be length 1")

})

