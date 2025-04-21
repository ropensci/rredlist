context("rl_latest functions")

test_that("rl_species_latest works", {
  skip_on_cran()

  vcr::use_cassette("rl_species_latest", {
    aa <- rl_species_latest("Gorilla", "gorilla")
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
  expect_is(aa$habitats, "data.frame")
})

test_that("rl_sis_latest works", {
  skip_on_cran()

  vcr::use_cassette("rl_sis_latest", {
    aa <- rl_sis_latest(9404)
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
  expect_is(aa$habitats, "data.frame")
})

test_that("rl_sis_latest works with no latest assessment", {
  skip_on_cran()

  vcr::use_cassette("rl_sis_latest-no-latest-assessment", {
    aa <- rl_sis_latest(41129)
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
})

test_that("rl_species_latest fails well", {
  skip_on_cran()

  expect_error(rl_species_latest(), "is missing, with no default")
  expect_error(rl_species_latest(5), "genus must be of class character")
  expect_error(rl_species_latest(list()), "genus must be of class character")

  expect_error(rl_species_latest("Gorilla", 5),
               "species must be of class character")
  expect_error(rl_species_latest("Gorilla", list()),
               "species must be of class character")

  expect_error(rl_species_latest("Gorilla", "gorilla", key = 5),
               "key must be of class character")
  expect_error(rl_species_latest("Gorilla", "gorilla", key = matrix()),
               "key must be of class character")

  expect_error(rl_species_latest("Gorilla", "gorilla", parse = 5),
               "parse must be of class logical")
  expect_error(rl_species_latest("Gorilla", "gorilla", parse = matrix()),
               "parse must be of class logical")
})

test_that("rl_sis_latest fails well", {
  skip_on_cran()

  expect_error(rl_sis_latest(), "is missing, with no default")

  expect_error(rl_sis_latest(166290968, key = 5),
               "key must be of class character")
  expect_error(rl_sis_latest(166290968, key = matrix()),
               "key must be of class character")

  expect_error(rl_sis_latest(166290968, parse = 5),
               "parse must be of class logical")
  expect_error(rl_sis_latest(166290968, parse = matrix()),
               "parse must be of class logical")
})
