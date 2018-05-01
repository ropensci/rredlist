context("rl_growth_forms functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_growth_forms", {
    aa <- rl_growth_forms('Quercus robur')

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_named(aa$result, "name")
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_growth_forms-not-parsing", {
    aa <- rl_growth_forms('Quercus robur', parse = FALSE)

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_named(aa$result[[1]], "name")
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_growth_forms_", {
    aa <- rl_growth_forms_('Mucuna bracteata')
    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c("name", "result"))
  })
})

test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_growth_forms-no-results", {
    aa <- rl_growth_forms('Mucuna asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_growth_forms(5), "name must be of class character")
  expect_error(rl_growth_forms(list()), "name must be of class character")

  expect_error(rl_growth_forms(id = "adsfds"), "id must be of class integer, numeric")
  expect_error(rl_growth_forms(id = list()), "id must be of class integer, numeric")

  expect_error(rl_growth_forms("ad", region = 5), "region must be of class character")
  expect_error(rl_growth_forms("ad", region = list()), "region must be of class character")

  expect_error(rl_growth_forms(key = 5), "key must be of class character")
  expect_error(rl_growth_forms(key = matrix()), "key must be of class character")

  expect_error(rl_growth_forms(parse = 5), "parse must be of class logical")
  expect_error(rl_growth_forms(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_growth_forms(letters[1:2]), "name must be length 1")
  expect_error(rl_growth_forms(id = 1:2), "id must be length 1")
  expect_error(rl_growth_forms(letters[1], region = letters[1:2]), "region must be length 1")
})

