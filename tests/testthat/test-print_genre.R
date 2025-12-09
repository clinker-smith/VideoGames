test_that("print_genre returns a data frame with correct columns", {
  result <- print_genre()

  expect_s3_class(result, "data.frame")
  expect_equal(names(result), c("Genre", "Count"))
})


