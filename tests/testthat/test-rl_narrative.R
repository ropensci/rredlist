context("rl_narrative functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_narrative", {
    aa <- rl_narrative('Fratercula arctica')

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "data.frame")
    expect_named(aa$result[,1:3], c("species_id", "taxonomicnotes", "rationale"))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_narrative-not-parsing", {
    aa <- rl_narrative('Fratercula arctica', parse = FALSE)

    expect_is(aa, "list")
    expect_named(aa, c("name", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$result, "list")
    expect_named(aa$result[[1]][1:3], c("species_id", "taxonomicnotes", "rationale"))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_narrative_", {
    aa <- rl_narrative_('Fratercula arctica')
    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c("name", "result"))
  })
})

test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_narrative-no-results", {
    aa <- rl_narrative('Loxodonta asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_narrative(5), "name must be of class character")
  expect_error(rl_narrative(list()), "name must be of class character")

  expect_error(rl_narrative(id = "adsfds"), "id must be of class integer, numeric")
  expect_error(rl_narrative(id = list()), "id must be of class integer, numeric")

  expect_error(rl_narrative("adsfa", region = 5), "region must be of class character")
  expect_error(rl_narrative("adsfa", region = list()), "region must be of class character")

  expect_error(rl_narrative(key = 5), "key must be of class character")
  expect_error(rl_narrative(key = matrix()), "key must be of class character")

  expect_error(rl_narrative(parse = 5), "parse must be of class logical")
  expect_error(rl_narrative(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_narrative(letters[1:2]), "name must be length 1")
  expect_error(rl_narrative(id = 1:2), "id must be length 1")
  expect_error(rl_narrative(letters[1], region = letters[1:2]), "region must be length 1")

})
