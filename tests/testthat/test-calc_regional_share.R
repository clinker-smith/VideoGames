test_that("calc_regional_share returns correct columns and values", {
  result <- calc_regional_share("Wii Sports Club")

  expect_s3_class(result, "data.frame")
  expect_equal(names(result), c("title", "na_share", "jp_share", "pal_share", "other_share", "total_sales"))
})

test_that("calc_regional_share throws error for non-existent game", {
  expect_error(calc_regional_share("This Game Does Not Exist"), "Game title not found")
})
