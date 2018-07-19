context("rl_synonyms functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_synonyms", {
    aa <- rl_synonyms('Loxodonta africana')

    expect_is(aa, "list")
    expect_named(aa, c("name", "count", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$count, "integer")
    expect_is(aa$result, "data.frame")
    expect_named(aa$result,
                 c('accepted_id', 'accepted_name', 'authority', 'synonym', 'syn_authority'))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_synonyms-not-parsing", {
    aa <- rl_synonyms('Loxodonta africana', parse = FALSE)

    expect_is(aa, "list")
    expect_named(aa, c("name", "count", "result"))
    expect_is(aa$name, "character")
    expect_is(aa$count, "integer")
    expect_is(aa$result, "list")
    expect_named(aa$result[[1]],
                 c('accepted_id', 'accepted_name', 'authority', 'synonym', 'syn_authority'))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_synonyms_", {
    aa <- rl_synonyms_('Loxodonta africana')
    aajson <- jsonlite::fromJSON(aa)

    expect_is(aa, "character")
    expect_is(aajson, "list")
    expect_named(aajson, c("name", "count", "result"))
  })
})

test_that("no results", {
  skip_on_cran()

  vcr::use_cassette("rl_synonyms-no-results", {
    aa <- rl_synonyms('Loxodonta asdfadf')

    expect_is(aa, "list")
    expect_is(aa$result, "list")
    expect_equal(length(aa$result), 0)
  })
})


test_that("fails well", {
  skip_on_cran()

  expect_error(rl_synonyms(5), "name must be of class character")
  expect_error(rl_synonyms(list()), "name must be of class character")

  expect_error(rl_synonyms(key = 5), "key must be of class character")
  expect_error(rl_synonyms(key = matrix()), "key must be of class character")

  expect_error(rl_synonyms(parse = 5), "parse must be of class logical")
  expect_error(rl_synonyms(parse = matrix()), "parse must be of class logical")

  # lengths
  expect_error(rl_synonyms(letters[1:2]), "name must be length 1")
})
