context("rl_habitats functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_habitats", {
    aa <- rl_habitats('Fratercula arctica')

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_true(any(grepl("breeding", aa$result$season, ignore.case = TRUE)))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_habitats-not-parsing", {
    aa <- rl_habitats('Fratercula arctica', parse = FALSE)

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_true(any(grepl("breeding", vapply(aa$result, "[[", "", "season"), ignore.case = TRUE)))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_habitats_", {
    aa <- rl_habitats_('Fratercula arctica')
    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c("name", "result"))
  })
})

test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_habitats-not-found", {
    aa <- rl_habitats('Loxodonta asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_habitats(5), "name must be of class character")
  expect_error(rl_habitats(list()), "name must be of class character")

  expect_error(rl_habitats(id = "adsfds"), "id must be of class integer, numeric")
  expect_error(rl_habitats(id = list()), "id must be of class integer, numeric")

  expect_error(rl_habitats("ab", region = 5), "region must be of class character")
  expect_error(rl_habitats("ab", region = list()), "region must be of class character")

  expect_error(rl_habitats(key = 5), "key must be of class character")
  expect_error(rl_habitats(key = matrix()), "key must be of class character")

  expect_error(rl_habitats(parse = 5), "parse must be of class logical")
  expect_error(rl_habitats(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_habitats(letters[1:2]), "name must be length 1")
  expect_error(rl_habitats(id = 1:2), "id must be length 1")
  expect_error(rl_habitats(letters[1], region = letters[1:2]), "region must be length 1")

})
