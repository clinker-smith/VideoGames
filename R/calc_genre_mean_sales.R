#' Video Game Mean Sales by Genre
#'
#' @description Computes the average global sales for each video game genre.
#' The function groups the dataset by genre and calculates
#' the mean of `total_sales` for each category.
#'
#' @importFrom dplyr group_by summarize arrange
#'
#' @details This function uses `group_by()` to separate games by genre and
#' `summarize()` to compute the mean global sales for each genre.
#' Missing values in `total_sales` are ignored.
#' The output is sorted from highest to lowest mean sales.
#'
#' @return A tibble with two columns:
#' \itemize{
#'   \item \code{genre} – the video game genre
#'   \item \code{mean_sales} – the mean global sales for that genre
#' }
#'
#' @examples
#' calc_genre_mean_sales()
#'
#' @export
calc_genre_mean_sales <- function(){
  VideoGames::vgchartz|>
    group_by(genre)|>
    summarize(mean_sales = mean(.data$total_sales, na.rm = TRUE))|>
    arrange(desc(mean_sales))
}
