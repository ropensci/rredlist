context("utility functions work")

test_that("ct works", {
  lst <- list(NULL, "a", NULL, "b")
  res <- ct(lst)
  expect_length(res, 2)
  expect_true(all(sapply(res, function(x) !is.null(x))))
})

test_that("rr_GET_raw works", {
  skip_on_cran()

  vcr::use_cassette("rr_GET_raw", {
    expect_no_error(res <- rr_GET_raw("taxa/family"))
  })
  expect_is(res, "HttpResponse")
  expect_equal(res$status_code, 200)
})

test_that("rr_GET works", {
  skip_on_cran()

  vcr::use_cassette("rr_GET", {
    expect_no_error(res <- rr_GET("taxa/family"))
  })
  expect_true(is.character(res))
  expect_equal(substr(res, 1, 1), "{")
})

test_that("check_key works", {
  expect_no_error(key <- check_key(NULL))
  expect_true(is.character(key))

  expect_no_error(key <- check_key("test"))
  expect_true(is.character(key))
  expect_equal(key, "test")
})

test_that("space works", {
  txt <- "Hello World"
  txt_encode <- space(txt)
  expect_true(is.character(txt_encode))
  expect_equal(txt_encode, "Hello%20World")
})

test_that("assert_is works", {
  x <- 42
  expect_no_error(assert_is(x, "numeric"))
  expect_error(assert_is(x, "character"))
  expect_no_error(assert_is(NULL, "numeric"))
})

test_that("assert_n works", {
  lst <- letters[1:5]
  expect_no_error(assert_n(lst, 5))
  expect_error(assert_n(lst, 42))
  lst2 <- as.list(lst)
  expect_no_error(assert_n(lst, 5))
  expect_error(assert_n(lst, 42))
  expect_no_error(assert_n(NULL, 5))
})

test_that("page_assessments and combine_assessments work", {
  skip_on_cran()

  vcr::use_cassette("Sturnidae_metadata", {
    res <- rr_GET_raw("taxa/family/Sturnidae",
                      key = NULL, query = list(page = 1))
  })
  total_pages <- as.integer(res$response_headers$`total-pages`)
  total_count <- as.integer(res$response_headers$`total-count`)
  vcr::use_cassette("page_assessments_multipage", {
    expect_no_error(pages <- page_assessments("taxa/family/Sturnidae",
                                              key = NULL, quiet = TRUE))
  })
  expect_true(is.list(pages))
  expect_length(pages, total_pages)
  expect_true(all(sapply(pages, function(x) is.character(x))))

  comb <- combine_assessments(pages, parse = TRUE)
  expect_true(is.list(comb))
  expect_true(is.data.frame(comb$assessments))
  expect_equal(nrow(comb$assessments), total_count)

  vcr::use_cassette("Rheidae_metadata", {
    res <- rr_GET_raw("taxa/family/Rheidae",
                      key = NULL, query = list(page = 1))
  })
  total_count <- as.integer(res$response_headers$`total-count`)

  vcr::use_cassette("page_assessments_singlepage", {
    expect_no_error(pages <- page_assessments("taxa/family/Rheidae",
                                              key = NULL, quiet = TRUE))
  })
  expect_true(is.character(pages))
  expect_length(pages, 1)

  comb <- combine_assessments(pages, parse = TRUE)
  expect_true(is.list(comb))
  expect_true(is.data.frame(comb$assessments))
  expect_equal(nrow(comb$assessments), total_count)
})
