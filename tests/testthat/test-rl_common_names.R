context("rl_common_names functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_common_names", {
    aa <- rl_common_names('Loxodonta africana')

    expect_is(aa, "list")
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_true(any(grepl("elephant", aa$result$taxonname, ignore.case = TRUE)))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_common_names-not-parsing", {
    aa <- rl_common_names('Loxodonta africana', parse = FALSE)

    expect_is(aa, "list")
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_true(any(grepl("elephant", vapply(aa$result, "[[", "", "taxonname"), ignore.case = TRUE)))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_common_names_", {
    aa <- rl_common_names_('Loxodonta africana')

    expect_is(aa, "character")
    expect_is(jsonlite::fromJSON(aa), "list")
  })
})


test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_common_names-no-results", {
    aa <- rl_common_names('Loxodonta asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_common_names(5), "name must be of class character")
  expect_error(rl_common_names(list()), "name must be of class character")

  expect_error(rl_common_names(key = 5), "key must be of class character")
  expect_error(rl_common_names(key = matrix()), "key must be of class character")

  expect_error(rl_common_names(parse = 5), "parse must be of class logical")
  expect_error(rl_common_names(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_common_names(letters[1:2]), "name must be length 1")
})

