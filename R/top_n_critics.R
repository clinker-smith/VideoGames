#' Video Game Highest Critics Generator
#'
#' @description Returns the top `n` video games ranked by critic score.
#' This function sorts games in descending order of critic score
#' and extracts the highest-rated titles.
#'
#' @importFrom dplyr select arrange slice_head
#'
#' @details The function arranges all games by their `critic_score`, then selects only
#' the game title and score. It returns the first `n` rows, representing the
#' highest rated games according to critic reviews.
#'
#' @param n A positive integer indicating the number of top-scoring games to return.
#'
#' @return A tibble with two columns:
#' \itemize{
#'   \item \code{title} – the title of the video game
#'   \item \code{critic_score} – the critic rating for the game
#' }
#'
#' @examples
#' top_n_critics(10)
#'
#' @export
top_n_critics <- function(n){
  VideoGames::vgchartz|>
    arrange(desc(critic_score))|>
    select(title, critic_score)|>
    slice_head(n = n)
}
