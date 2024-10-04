context("rl_sis functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_sis", {
    aa <- rl_sis(9404)
  })

  expect_is(aa, "list")
  expect_named(aa, c("sis_id", "taxon", "assessments"))
  expect_is(aa$sis_id, "integer")
  expect_is(aa$taxon, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_sis-not-parsing", {
    aa <- rl_sis(9404, parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("sis_id", "taxon", "assessments"))
  expect_is(aa$sis_id, "integer")
  expect_is(aa$taxon, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_sis_", {
    aa <- rl_sis_(9404, all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("sis_id", "taxon", "assessments"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_sis(), "is missing, with no default")

  expect_error(rl_sis("5"), "id must be of class integer")
  expect_error(rl_sis(list()), "id must be of class integer")

  expect_error(rl_sis(9404, key = 5),
               "key must be of class character")
  expect_error(rl_sis(9404, key = matrix()),
               "key must be of class character")
})
