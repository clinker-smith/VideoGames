#' Print video game installments
#'
#' @description This function prints the number of installments for a given video game title.
#'
#' @details This function takes the argument of a video game franchise name. It searches through
#' all video games in the dataset for a matching pattern of characters. For instance, if "Red Dead"
#' is used as the argument, all video games with "Read Dead" in the title will be returned. The
#' function is not case sensitive.
#'
#' @param x The dataframe 'vgchartz_2024' stored in data file, function includes filtering the data
#' to unique observations only (no repeated titles)
#'
#' @return Prints a statement saying how many installments of a franchise exist in the data
#'
#' @examples
#' # print_installments("Red Dead")
#' ### There were 9 installments found for games with Red Dead in the title
#' # print_installments("Red Dead Redemption II")
#' ### There were 1 installments found for games with Red Dead in the title
#'
#' @export
print_installments <- function(game_title) {
  game_title_lower <- tolower(game_title)

  df_short <- unique(VideoGames::vgchartz["title"])

  matches <- grepl(game_title_lower, tolower(df_short$title))

  count <- sum(matches, na.rm = TRUE)

  cat("There were", count, "installments found for games with", game_title, "in the title")
}
