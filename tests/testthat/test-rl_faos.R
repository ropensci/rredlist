context("rl_faos functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_faos-def", {
    aa <- rl_faos()
  })

  expect_is(aa, "list")
  expect_named(aa, c("faos"))
  expect_is(aa$faos, "data.frame")

  vcr::use_cassette("rl_faos", {
    aa <- rl_faos('18')
  })

  expect_is(aa, "list")
  expect_named(aa, c("fao", "assessments", "filters"))
  expect_is(aa$fao, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_faos-def-not-parsing", {
    aa <- rl_faos(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("faos"))
  expect_is(aa$faos, "list")

  vcr::use_cassette("rl_faos-not-parsing", {
    aa <- rl_faos('18', parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("fao", "assessments", "filters"))
  expect_is(aa$fao, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_faos_-def", {
    aa <- rl_faos_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("faos"))
  expect_is(aajson$faos, "data.frame")

  vcr::use_cassette("rl_faos_", {
    aa <- rl_faos_('18', all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("fao", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_faos(5), "code must be of class character")
  expect_error(rl_faos(list()), "code must be of class character")

  expect_error(rl_faos(key = 5), "key must be of class character")
  expect_error(rl_faos(key = matrix()), "key must be of class character")

  expect_error(rl_faos(parse = 5), "parse must be of class logical")
  expect_error(rl_faos(parse = matrix()), "parse must be of class logical")

  expect_error(rl_faos(page = "next"), "page must be of class integer")
  expect_error(rl_faos(all = "yes"), "all must be of class logical")
  expect_error(rl_faos(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_faos(page = 1:2), "page must be length 1")

})
