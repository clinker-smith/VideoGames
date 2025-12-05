#' Video Game Console Printer
#'
#' @description This function prints the number of video games available for each gaming console.
#'
#' @details This function takes in a data frame containing a column named `console` as well as an
#' integer that represents the numbers of rows that will be printed. After data wrangling the table
#' with dplyr functions, the function checks if the index value is within valid range. If not,
#' a custom error will be printed. If so, then a tibble with the desired number of rows will be printed.
#'
#' @param .data A data frame containing a column named `console` representing gaming consoles
#' @param x An integer value that represents the number of rows that will be printed.
#'
#' @returns Returns a tibble with a column that says `Console Type` and another that says
#' `Number of Video Games`. The user chooses how many rows of the tibble will be printed.
#'
#'
#' @examples
#' ## Not run:
#' ## vg_data <- read.csv("vgchartz-2024.csv")
#' ## print_console(vg_data, 10)
#' ## End(Not run)
#'
#' @export
print_console <- function(.data, x){
  x <- as.numeric(x)
  console_df <- .data |>
    dplyr::group_by(console) |>
    dplyr::count(console) |>
    dplyr::arrange(desc(n))

  if (x < 1 || x > nrow(console_df)){
    stop("Error: the index value is out of range")
    break}
  else{
    names(console_df) <- c("Console Type", "Number of Video Games")
    print(console_df, n = x)
    invisible(console_df)}}
