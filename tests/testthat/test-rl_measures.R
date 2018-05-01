context("rl_measures functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_measures", {
    aa <- rl_measures('Fratercula arctica')

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_named(aa$result, c("code", "title"))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_measures-not-parsing", {
    aa <- rl_measures('Fratercula arctica', parse = FALSE)

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_named(aa$result[[1]], c("code", "title"))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_measures_", {
    aa <- rl_measures_('Fratercula arctica')
    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c("name", "result"))
  })
})

test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_measures-no-results", {
    aa <- rl_measures('Loxodonta asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_measures(5), "name must be of class character")
  expect_error(rl_measures(list()), "name must be of class character")

  expect_error(rl_measures(id = "adsfds"), "id must be of class integer, numeric")
  expect_error(rl_measures(id = list()), "id must be of class integer, numeric")

  expect_error(rl_measures("ad", region = 5), "region must be of class character")
  expect_error(rl_measures("ad", region = list()), "region must be of class character")

  expect_error(rl_measures(key = 5), "key must be of class character")
  expect_error(rl_measures(key = matrix()), "key must be of class character")

  expect_error(rl_measures(parse = 5), "parse must be of class logical")
  expect_error(rl_measures(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_measures(letters[1:2]), "name must be length 1")
  expect_error(rl_measures(id = 1:2), "id must be length 1")
  expect_error(rl_measures(letters[1], region = letters[1:2]), "region must be length 1")
})

