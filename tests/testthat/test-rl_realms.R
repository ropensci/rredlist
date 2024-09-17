context("rl_realms functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_realms-def", {
    aa <- rl_realms()
  })

  expect_is(aa, "list")
  expect_named(aa, c("biogeographical_realms"))
  expect_is(aa$biogeographical_realms, "data.frame")

  vcr::use_cassette("rl_realms", {
    aa <- rl_realms('1')
  })

  expect_is(aa, "list")
  expect_named(aa, c("biogeographical_realm", "assessments", "filters"))
  expect_is(aa$biogeographical_realm, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_realms-def-not-parsing", {
    aa <- rl_realms(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("biogeographical_realms"))
  expect_is(aa$biogeographical_realms, "list")

  vcr::use_cassette("rl_realms-not-parsing", {
    aa <- rl_realms('1', parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("biogeographical_realm", "assessments", "filters"))
  expect_is(aa$biogeographical_realm, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_realms_-def", {
    aa <- rl_realms_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("biogeographical_realms"))
  expect_is(aajson$biogeographical_realms, "data.frame")

  vcr::use_cassette("rl_realms_", {
    aa <- rl_realms_('1', all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("biogeographical_realm", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_realms(5), "code must be of class character")
  expect_error(rl_realms(list()), "code must be of class character")

  expect_error(rl_realms(key = 5), "key must be of class character")
  expect_error(rl_realms(key = matrix()), "key must be of class character")

  expect_error(rl_realms(parse = 5), "parse must be of class logical")
  expect_error(rl_realms(parse = matrix()), "parse must be of class logical")

  expect_error(rl_realms(page = "next"), "page must be of class integer")
  expect_error(rl_realms(all = "yes"), "all must be of class logical")
  expect_error(rl_realms(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_realms(page = 1:2), "page must be length 1")

})
