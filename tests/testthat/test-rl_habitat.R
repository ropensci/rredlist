context("rl_habitats functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_habitats-def", {
    aa <- rl_habitats()
  })

  expect_is(aa, "list")
  expect_named(aa, c("habitats"))
  expect_is(aa$habitats, "data.frame")

  vcr::use_cassette("rl_habitats", {
    aa <- rl_habitats('2')
  })

  expect_is(aa, "list")
  expect_named(aa, c("habitat", "assessments", "filters"))
  expect_is(aa$habitat, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_habitats-def-not-parsing", {
    aa <- rl_habitats(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("habitats"))
  expect_is(aa$habitats, "list")

  vcr::use_cassette("rl_habitats-not-parsing", {
    aa <- rl_habitats('2', parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("habitat", "assessments", "filters"))
  expect_is(aa$habitat, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_habitats_-def", {
    aa <- rl_habitats_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("habitats"))
  expect_is(aajson$habitats, "data.frame")

  vcr::use_cassette("rl_habitats_", {
    aa <- rl_habitats_('2', all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("habitat", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_habitats(5), "code must be of class character")
  expect_error(rl_habitats(list()), "code must be of class character")

  expect_error(rl_habitats(key = 5), "key must be of class character")
  expect_error(rl_habitats(key = matrix()), "key must be of class character")

  expect_error(rl_habitats(parse = 5), "parse must be of class logical")
  expect_error(rl_habitats(parse = matrix()), "parse must be of class logical")

  expect_error(rl_habitats(page = "next"), "page must be of class integer")
  expect_error(rl_habitats(all = "yes"), "all must be of class logical")
  expect_error(rl_habitats(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_habitats(page = 1:2), "page must be length 1")

})
