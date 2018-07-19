context("rl_search functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_search", {
    aa <- rl_search('Fratercula arctica')

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_true(any(grepl("arctica", aa$result$scientific_name, ignore.case = TRUE)))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_search-not-parsing", {
    aa <- rl_search('Fratercula arctica', parse = FALSE)

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_true(any(grepl("arctica", vapply(aa$result, "[[", "", "scientific_name"), ignore.case = TRUE)))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_search_", {
    aa <- rl_search_('Fratercula arctica')
    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c("name", "result"))
  })
})

test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_search-no-results", {
    aa <- rl_search('Loxodonta asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_search(5), "name must be of class character")
  expect_error(rl_search(list()), "name must be of class character")

  expect_error(rl_search(id = "adsfds"), "id must be of class integer, numeric")
  expect_error(rl_search(id = list()), "id must be of class integer, numeric")

  expect_error(rl_search("adfadf", region = 5), "region must be of class character")
  expect_error(rl_search("adfadf", region = list()), "region must be of class character")

  expect_error(rl_search(key = 5), "key must be of class character")
  expect_error(rl_search(key = matrix()), "key must be of class character")

  expect_error(rl_search(parse = 5), "parse must be of class logical")
  expect_error(rl_search(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_search(letters[1:2]), "name must be length 1")
  expect_error(rl_search(id = 1:2), "id must be length 1")
  expect_error(rl_search(letters[1], region = letters[1:2]), "region must be length 1")
})

