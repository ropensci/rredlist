context("rl_history functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_history", {
    aa <- rl_history('Loxodonta africana')

    expect_is(aa, "list")
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_true(any(grepl("Vulnerable", aa$result$category, ignore.case = TRUE)))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_history-not-parsing", {
    aa <- rl_history('Loxodonta africana', parse = FALSE)

    expect_is(aa, "list")
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_true(any(grepl("Vulnerable", vapply(aa$result, "[[", "", "category"), ignore.case = TRUE)))
  })
})

test_that("high level works - by ID", {
  skip_on_cran()

  vcr::use_cassette("rl_history-by-id", {
    aa <- rl_history(id = 12392)

    expect_is(aa, "list")
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_true(any(grepl("Vulnerable", aa$result$category, ignore.case = TRUE)))
  })
})

test_that("high level works - region", {
  skip_on_cran()

  vcr::use_cassette("rl_history-region-together", {
    aa <- rl_history(id = 22823, region = 'europe')

    expect_is(aa, "list")
    expect_named(aa, c('name', 'region_identifier', 'result'))
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_gt(NROW(aa$result), 0)

    bb <- rl_history(id = 22823, region = 'mediterranean')

    expect_is(bb, "list")
    expect_named(bb, c('name', 'region_identifier', 'result'))
    expect_is(bb$name, "character")
    expect_is(bb$result, "list")
    expect_equal(length(bb$result), 0)
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_history_", {
    aa <- rl_history_('Ursus maritimus', region = 'europe')

    expect_is(aa, "character")
    expect_is(jsonlite::fromJSON(aa), "list")
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_history(), "is not TRUE")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_history(5), "name must be of class character")
  expect_error(rl_history(list()), "name must be of class character")

  expect_error(rl_history(id = "adsfds"), "id must be of class integer, numeric")
  expect_error(rl_history(id = list()), "id must be of class integer, numeric")

  expect_error(rl_history("ab", region = 5), "region must be of class character")
  expect_error(rl_history("ab", region = list()), "region must be of class character")

  expect_error(rl_history(key = 5), "key must be of class character")
  expect_error(rl_history(key = matrix()), "key must be of class character")

  expect_error(rl_history(parse = 5), "parse must be of class logical")
  expect_error(rl_history(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_history(letters[1:2]), "name must be length 1")
  expect_error(rl_history(id = 1:2), "id must be length 1")
  expect_error(rl_history(letters[1], region = letters[1:2]), "region must be length 1")

})
