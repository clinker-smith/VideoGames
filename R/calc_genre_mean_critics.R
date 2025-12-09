#' Video Game Mean Critic Score Calculator
#'
#' @description This function calculates the mean critic score and presents it in a formatted tible,
#' including a custom message near the end.
#'
#' @details This function takes in a data frame that contains a column named `critic_score`. After
#' doing necessary data wrangling using tidyr and dplyr, the function will calculate the mean
#' critic score for each video game genre. At the end, "Warning: NA values were dropped" is written in
#' red and is flanked by two "anger" emojis.
#'
#' @param .data A data frame containing a column named `critic_score`
#'
#' @returns Returns a tibble with a column called `Genre` and another called `Mean Critic Score`
#' followed by a warning message that all NA values were dropped, including emojis and red text.
#'
#' @examples
#' ## Not run:
#' ## vg_data <- read.csv("vgchartz-2024.csv")
#' ## calc_genre_mean_critics(vg_data)
#' ## End(Not run)
#'
#' @export
calc_genre_mean_critics <- function(.data){
  critics_df <- .data |>
    dplyr::group_by(genre) |>
    tidyr::drop_na(critic_score) |>
    dplyr::summarize(mean_critics = mean(critic_score)) |>
    dplyr::arrange(desc(mean_critics))

  names(critics_df) <- c("Genre", "Mean Critic Score")
  print(critics_df)
  cat(crayon::red(emoji::emoji("anger"), "Warning: NA values were dropped", emoji::emoji("anger")))}

