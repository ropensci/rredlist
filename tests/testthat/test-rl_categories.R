context("rl_categories functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_categories-def", {
    aa <- rl_categories()
  })

  expect_is(aa, "list")
  expect_named(aa, c("red_list_categories"))
  expect_is(aa$red_list_categories, "data.frame")

  vcr::use_cassette("rl_categories", {
    aa <- rl_categories("EW")
  })

  expect_is(aa, "list")
  expect_named(aa, c("red_list_category", "assessments", "filters"))
  expect_is(aa$red_list_category, "data.frame")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_categories-def-not-parsing", {
    aa <- rl_categories(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("red_list_categories"))
  expect_is(aa$red_list_categories, "list")

  vcr::use_cassette("rl_categories-not-parsing", {
    aa <- rl_categories("EW", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("red_list_category", "assessments", "filters"))
  expect_is(aa$red_list_category, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_categories_-def", {
    aa <- rl_categories_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("red_list_categories"))
  expect_is(aajson$red_list_categories, "data.frame")

  vcr::use_cassette("rl_categories_", {
    aa <- rl_categories_("EW", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("red_list_category", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_categories(5), "code must be of class character")
  expect_error(rl_categories(list()), "code must be of class character")

  expect_error(rl_categories(key = 5), "key must be of class character")
  expect_error(rl_categories(key = matrix()), "key must be of class character")

  expect_error(rl_categories(parse = 5), "parse must be of class logical")
  expect_error(rl_categories(parse = matrix()),
               "parse must be of class logical")

  expect_error(rl_categories(page = "next"), "page must be of class integer")
  expect_error(rl_categories(all = "yes"), "all must be of class logical")
  expect_error(rl_categories(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_categories(page = 1:2), "page must be length 1")
})

suppressPackageStartupMessages(library(ggplot2, quietly = TRUE))

categories <- c("NE", "DD", "LC", "NT", "VU", "EN", "CR", "RE", "EW", "EX")
set.seed(1234)
df <- data.frame(
  x = runif(1000, 0, 10), y = runif(1000, 0, 10),
  color = sample(categories, 1000, TRUE)
)

test_that("scale_fill_iucn works", {
  gg <- ggplot(df) +
    geom_point(aes(x = x, y = y, fill = color), shape = 21) +
    scale_fill_iucn() +
    theme_classic()
  expect_doppelganger("scale_fill_iucn", gg)
})

test_that("scale_color_iucn works", {
  gg <- ggplot(df) +
    geom_point(aes(x = x, y = y, color = color), shape = 21) +
    scale_color_iucn() +
    theme_classic()
  expect_doppelganger("scale_color_iucn", gg)
})
