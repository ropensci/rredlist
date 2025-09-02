context("rl_assessment functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment", {
    aa <- rl_assessment(166290968)
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
  expect_is(aa$habitats, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment-not-parsing", {
    aa <- rl_assessment(166290968, parse = FALSE)
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
  expect_is(aa$habitats, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment_", {
    aa <- rl_assessment_(166290968)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_is(aajson$taxon, "list")
  expect_is(aajson$habitats, "data.frame")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_assessment(), "is missing, with no default")

  expect_error(rl_assessment(166290968, key = 5),
               "key must be of class character")
  expect_error(rl_assessment(166290968, key = matrix()),
               "key must be of class character")

  expect_error(rl_assessment(166290968, parse = 5),
               "parse must be of class logical")
  expect_error(rl_assessment(166290968, parse = matrix()),
               "parse must be of class logical")
})

test_that("rl_assessment_list works", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment_list", {
    aa <- rl_assessment_list(ids = c(166290968, 136250858))
  })

  vcr::use_cassette("rl_assessment_list_check1", {
    bb <- rl_assessment(166290968)
  })
  vcr::use_cassette("rl_assessment_list_check2", {
    cc <- rl_assessment(136250858)
  })

  vcr::use_cassette("rl_assessment_list_warning", {
    expect_message(rl_assessment_list(ids = c(166290968, 136250858),
                                      wait_time = 0), "short wait time")
  })

  vcr::use_cassette("rl_assessment_list_warning2", {
    expect_message(rl_assessment_list(ids = c(5, 136250858)), "Couldn't find")
  })

  expect_is(aa, "list")
  expect_length(aa, 2)
  expect_equal(aa[[1]], bb)
  expect_equal(aa[[2]], cc)

  expect_error(rl_assessment_list(), "is missing, with no default")
  expect_error(rl_assessment_list(ids = ""),
               "ids must be of class integer")
  expect_error(rl_assessment_list(166290968, wait_time = "never"),
               "wait_time must be of class integer")
  expect_error(rl_assessment_list(166290968, quiet = "yes"),
               "quiet must be of class logical")
})

test_that("rl_assessment_extract works", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment_list_for_extract", {
    aa <- rl_assessment_list(ids = c(166290968, 136250858))
  })

  extract <- rl_assessment_extract(aa, "taxon")
  expect_is(extract, "list")
  expect_length(extract, 2)
  expect_is(extract[[1]], "list")

  extract2 <- rl_assessment_extract(aa, "taxon__common_names", format = "df")
  expect_is(extract2, "data.frame")
  expect_equal(nrow(extract2), 2)
  expect_is(extract2$common_names, "list")
  expect_equal(colnames(extract2)[1], "assessment_id")

  extract3 <- rl_assessment_extract(aa, "taxon__common_names", format = "df",
                                    flatten = TRUE)
  expect_is(extract3, "data.frame")
  expect_equal(nrow(extract3), sum(nrow(extract2$common_names[[1]]),
                                   nrow(extract2$common_names[[2]])))

  extract4 <- rl_assessment_extract(aa, "threats", format = "df",
                                    flatten = TRUE)
  expect_is(extract4, "data.frame")

  extract5 <- rl_assessment_extract(aa, "taxon__kingdom_name", format = "df")
  expect_is(extract5, "data.frame")
  expect_named(extract5, c("assessment_id", "kingdom_name"))

  extract6 <- rl_assessment_extract(aa, "taxon__kingdom_name", format = "df",
                                    flatten = TRUE)
  expect_is(extract6, "data.frame")
  expect_named(extract6, c("assessment_id", "kingdom_name"))
  expect_equal(extract5, extract6)

  extract7 <- rl_assessment_extract(aa, "taxon", format = "df", flatten = TRUE)
  expect_is(extract7, "data.frame")
  expect_equal(colnames(extract7)[1], "assessment_id")
  expect_equal(extract7$kingdom_name, extract6$kingdom_name)

  # test with a vector of elements to extract
  extract8 <- rl_assessment_extract(aa, c("taxon", "threats"))
  expect_is(extract8, "list")
  expect_length(extract8, 2)
  expect_is(extract8[[1]], "list")
  expect_is(extract8[[2]], "list")
  expect_true("kingdom_name" %in% names(extract8[[1]]))
  expect_true("code" %in% names(extract8[[1]]))

  extract9 <- rl_assessment_extract(aa, c("taxon", "threats"),
                                    format = "df", flatten = TRUE)
  expect_is(extract9, "data.frame")
  expect_equal(colnames(extract9)[1], "assessment_id")
  expect_true("kingdom_name" %in% colnames(extract9))
  expect_true("code" %in% colnames(extract9))

  expect_error(rl_assessment_extract(), "is missing, with no default")
  expect_error(rl_assessment_extract(lst = 166290968, el_name = "taxon"),
               "lst must be of class list")
  expect_error(rl_assessment_extract(aa, el_name = 5),
               "el_name must be of class character")
  expect_error(rl_assessment_extract(aa, el_name = "abcdefg"),
               "not found")
  expect_error(rl_assessment_extract(aa, c("taxon", "abcdefg")),
               "not found")
  expect_error(rl_assessment_extract(aa, el_name = "taxon", format = TRUE),
               "format must be of class character")
  expect_error(rl_assessment_extract(aa, el_name = "taxon", format = "test"))
  expect_error(rl_assessment_extract(aa, el_name = "taxon", flatten = "yes"),
               "flatten must be of class logical")
})
