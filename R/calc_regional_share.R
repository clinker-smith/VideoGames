#' Video Game Regional Share of Global Sales
#'
#' @description Calculates the sales share of all major regions for a single video game.
#' The regions include North America (`na_sales`), Japan (`jp_sales`),
#' Europe & Africa (`pal_sales`), and other regions (`other_sales`).
#'
#' @importFrom dplyr filter mutate select
#'
#' @details This function calculates the distribution of a video game's total global
#' sales across the four main regions: North America (`na_sales`), Japan (`jp_sales`),
#' Europe & Africa (`pal_sales`), and other regions (`other_sales`).
#'
#' @param game_title The title of the video game to analyze.
#'
#' @return A tibble with columns:
#' \itemize{
#'   \item \code{title} – the game title
#'   \item \code{na_share, jp_share, pal_share, other_share} – percentage of global sales by region
#'   \item \code{total_sales} – global sales
#' }
#'
#' @examples
#' calc_regional_share("Wii Sports Club")
#'
#' @export
calc_regional_share <- function(game_title) {
  data <- VideoGames::vgchartz |>
    filter(title == game_title)

  if (nrow(data) == 0) {
    stop("Game title not found in the dataset.")
  }

  sales_columns <- c("total_sales", "na_sales", "jp_sales", "pal_sales", "other_sales")
  if (any(is.na(data[sales_columns]))) {
    warning("Some sales values are NA. Regional shares may also be NA. Try another game.")
  }

  data |>
    mutate(na_share = (na_sales/total_sales) * 100,
           jp_share = (jp_sales/total_sales) * 100,
           pal_share = (pal_sales/total_sales) * 100,
           other_share = (other_sales/total_sales) * 100) |>
    select(title, na_share, jp_share, pal_share, other_share, total_sales)
}

