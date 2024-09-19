context("rl_threats functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_threats-def", {
    aa <- rl_threats()
  })

  expect_is(aa, "list")
  expect_named(aa, c("threats"))
  expect_is(aa$threats, "data.frame")

  vcr::use_cassette("rl_threats", {
    aa <- rl_threats("9_5_1")
  })

  expect_is(aa, "list")
  expect_named(aa, c("threat", "assessments", "filters"))
  expect_is(aa$threat, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_threats-def-not-parsing", {
    aa <- rl_threats(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("threats"))
  expect_is(aa$threats, "list")

  vcr::use_cassette("rl_threats-not-parsing", {
    aa <- rl_threats("9_5_1", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("threat", "assessments", "filters"))
  expect_is(aa$threat, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_threats_-def", {
    aa <- rl_threats_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("threats"))
  expect_is(aajson$threats, "data.frame")

  vcr::use_cassette("rl_threats_", {
    aa <- rl_threats_("9_5_1", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("threat", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_threats(5), "code must be of class character")
  expect_error(rl_threats(list()), "code must be of class character")

  expect_error(rl_threats(key = 5), "key must be of class character")
  expect_error(rl_threats(key = matrix()), "key must be of class character")

  expect_error(rl_threats(parse = 5), "parse must be of class logical")
  expect_error(rl_threats(parse = matrix()), "parse must be of class logical")

  expect_error(rl_threats(page = "next"), "page must be of class integer")
  expect_error(rl_threats(all = "yes"), "all must be of class logical")
  expect_error(rl_threats(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_threats(page = 1:2), "page must be length 1")

})
