#' Video Game Genre Printer
#'
#' @description This function prints a table showing each video game genre in the dataset
#' along with the count of games in that genre. Genres are displayed in
#' descending order of popularity.
#'
#' @importFrom dplyr count arrange
#'
#' @details This function takes a data frame containing a column named `genre` and
#' calculates the number of games in each genre. It then arranges the genres
#' from most common to least common. The output is printed directly to the
#' console.
#'
#' @return Prints a data frame called `genre_df` with two columns:
#' \itemize{
#'   \item \bold{Genre}: The name of the video game genre.
#'   \item \bold{Count}: The number of games in that genre.
#' }
#'
#' @examples
#' print_genre()
#'
#' @export
print_genre <- function(){
  genre_df <- VideoGames::vgchartz|>
    count(genre) |>
    arrange(desc(n))

  names(genre_df) <- c("Genre", "Count")
  return(genre_df)
}
