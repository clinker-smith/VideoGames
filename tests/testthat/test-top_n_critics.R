test_that("top_n_critics returns correct number of rows", {
  n <- 5
  result <- top_n_critics(n)

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), n)
  expect_true(all(c("title", "critic_score") %in% names(result)))
})

test_that("top_n_critics is sorted by critic_score descending", {
  result <- top_n_critics(10)

  expect_true(all(diff(result$critic_score) <= 0))
})

