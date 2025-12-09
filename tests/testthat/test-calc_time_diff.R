test_that("calc_time_diff returns time difference", {
  .data <- data.frame(
    release_date = as.Date("2020-01-01"),
    last_update  = as.Date("2020-02-01"))

  x <- 1
  result <- calc_time_diff(difftime, x)

  expect_s3_class(result, "character")
  expect_equal(result, "Time difference of 4.428571 weeks")})

test_that("calc_time_diff shows custom error messages when needed", {
  .data <- data.frame(
    release_date = as.Date(NA),
    last_update  = as.Date(NA))
  x <- 1

  expect_error(calc_time_diff(.data, x), "Error: this video game has no listed release or update date.")})

test_that("calc_time_diff shows custom error messages when needed", {
  .data <- data.frame(
    release_date = as.Date("2020-01-01"),
    last_update  = as.Date(NA))
  x <- 1

  expect_error(calc_time_diff(.data, x), "Error: this video game has no listed update date.")})

test_that("calc_time_diff shows custom error messages when needed", {
  .data <- data.frame(
    release_date = as.Date(NA),
    last_update  = as.Date("2020-02-01"))
  x <- 1

  expect_error(calc_time_diff(.data, x), "Error: this video game has no listed release date.")
})
