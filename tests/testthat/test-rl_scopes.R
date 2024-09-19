context("rl_scopes functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_scopes-def", {
    aa <- rl_scopes()
  })

  expect_is(aa, "list")
  expect_named(aa, c("scopes"))
  expect_is(aa$scopes, "data.frame")

  vcr::use_cassette("rl_scopes", {
    aa <- rl_scopes("100765562")
  })

  expect_is(aa, "list")
  expect_named(aa, c("scope", "assessments", "filters"))
  expect_is(aa$scope, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_scopes-def-not-parsing", {
    aa <- rl_scopes(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("scopes"))
  expect_is(aa$scopes, "list")

  vcr::use_cassette("rl_scopes-not-parsing", {
    aa <- rl_scopes("100765562", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("scope", "assessments", "filters"))
  expect_is(aa$scope, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_scopes_-def", {
    aa <- rl_scopes_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("scopes"))
  expect_is(aajson$scopes, "data.frame")

  vcr::use_cassette("rl_scopes_", {
    aa <- rl_scopes_("100765562", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("scope", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_scopes(5), "code must be of class character")
  expect_error(rl_scopes(list()), "code must be of class character")

  expect_error(rl_scopes(key = 5), "key must be of class character")
  expect_error(rl_scopes(key = matrix()), "key must be of class character")

  expect_error(rl_scopes(parse = 5), "parse must be of class logical")
  expect_error(rl_scopes(parse = matrix()), "parse must be of class logical")

  expect_error(rl_scopes(page = "next"), "page must be of class integer")
  expect_error(rl_scopes(all = "yes"), "all must be of class logical")
  expect_error(rl_scopes(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_scopes(page = 1:2), "page must be length 1")

})
