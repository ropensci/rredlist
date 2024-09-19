context("rl_systems functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_systems-def", {
    aa <- rl_systems()
  })

  expect_is(aa, "list")
  expect_named(aa, c("systems"))
  expect_is(aa$systems, "data.frame")

  vcr::use_cassette("rl_systems", {
    aa <- rl_systems("2", all = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("system", "assessments", "filters"))
  expect_is(aa$system, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_systems-def-not-parsing", {
    aa <- rl_systems(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("systems"))
  expect_is(aa$systems, "list")

  vcr::use_cassette("rl_systems-not-parsing", {
    aa <- rl_systems("2", parse = FALSE, all = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("system", "assessments", "filters"))
  expect_is(aa$system, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_systems_-def", {
    aa <- rl_systems_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("systems"))
  expect_is(aajson$systems, "data.frame")

  vcr::use_cassette("rl_systems_", {
    aa <- rl_systems_("2", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("system", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_systems(5), "code must be of class character")
  expect_error(rl_systems(list()), "code must be of class character")

  expect_error(rl_systems(key = 5), "key must be of class character")
  expect_error(rl_systems(key = matrix()), "key must be of class character")

  expect_error(rl_systems(parse = 5), "parse must be of class logical")
  expect_error(rl_systems(parse = matrix()), "parse must be of class logical")

  expect_error(rl_systems(page = "next"), "page must be of class integer")
  expect_error(rl_systems(all = "yes"), "all must be of class logical")
  expect_error(rl_systems(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_systems(page = 1:2), "page must be length 1")
})
