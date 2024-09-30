context("rl_species functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_species", {
    aa <- rl_species("Gorilla", "gorilla")
  })

  expect_is(aa, "list")
  expect_named(aa, c("taxon", "assessments", "params"))
  expect_is(aa$taxon, "list")
  expect_is(aa$assessments, "data.frame")
  expect_is(aa$params, "list")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_species-not-parsing", {
    aa <- rl_species("Gorilla", "gorilla", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("taxon", "assessments", "params"))
  expect_is(aa$taxon, "list")
  expect_is(aa$assessments, "list")
  expect_is(aa$params, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_species_", {
    aa <- rl_species_("Gorilla", "gorilla", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("taxon", "assessments", "params"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_species(), "is missing, with no default")

  expect_error(rl_species(5), "genus must be of class character")
  expect_error(rl_species(list()), "genus must be of class character")

  expect_error(rl_species("Gorilla", 5), "species must be of class character")
  expect_error(rl_species("Gorilla", list()),
               "species must be of class character")

  expect_error(rl_species("Gorilla", "gorilla", key = 5),
               "key must be of class character")
  expect_error(rl_species("Gorilla", "gorilla", key = matrix()),
               "key must be of class character")

  expect_error(rl_species("Gorilla", "gorilla", parse = 5),
               "parse must be of class logical")
  expect_error(rl_species("Gorilla", "gorilla", parse = matrix()),
               "parse must be of class logical")

  expect_error(rl_species("Gorilla", "gorilla", infra = 5),
               "infra must be of class character")
  expect_error(rl_species("Gorilla", "gorilla", subpopulation = 2),
               "subpopulation must be of class character")
})
