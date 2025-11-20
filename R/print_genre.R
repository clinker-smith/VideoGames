#' Video Game Genre Printer
#'
#' @description This function prints a table showing each video game genre in the dataset
#' along with the count of games in that genre. Genres are displayed in
#' descending order of popularity.
#'
#' @details This function takes a data frame containing a column named `genre` and
#' calculates the number of games in each genre. It then arranges the genres
#' from most common to least common. The output is printed directly to the
#' console.
#'
#' @param .data A data frame containing a column named `genre` representing
#' video game genres.
#'
#' @return Prints a data frame called `genre_df` with two columns:
#' \itemize{
#'   \item \bold{Genre}: The name of the video game genre.
#'   \item \bold{Count}: The number of games in that genre.
#' }
#' The function returns `NULL` invisibly after printing.
#'
#' @examples
#' ## Not run:
#' ## vg_data <- read.csv("vgchartz-2024.csv")
#' ## print_genre(vg_data)
#' ## End(Not run)
#'
#' @export
print_genre <- function(.data){
  genre_df <- .data |>
    dplyr::count(genre) |>
    dplyr::arrange(desc(n))

  names(genre_df) <- c("Genre", "Count")
  print(genre_df)
  invisible(genre_df)
}
