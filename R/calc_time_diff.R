#' Video Game Release Date & Update Date Time Difference Calculator
#'
#' @description This function calculates the time difference between the video game’s release date
#' and the date it was last updated.
#'
#' @details This function takes in a data frame containing a column named `release_date` and a
#' column named `last_update` as well as an integer that represents the row number of interest.
#' After making sure all needed values are in correct format, the function checks to see if
#' the `release_date` and/or `last_update` columns have NA values. If so, custom errors are returned.
#' Assuming that both columns don't have NA values, the time difference between each is calculated.
#'
#' @param .data A data frame containing a column named `release_date` and a
#' column named `last_update`
#' @param x The data frame's row number; this has to be an integer value
#'
#' @returns Returns a sentence that says "Time difference of ___ weeks";
#' where ___ represents the calculated time difference
#'
#' @examples
#' name <- c("Just Dance 4", "Call of Duty: Black Ops 3")
#' dates1 <- c("2018-01-31", "2018-01-14")
#' dates2 <- c("2012-10-09", "2015-11-06")
#' df <- data.frame(video_game_name = name, last_update = dates1, release_date = dates2)
#'
#' calc_time_diff(df, 1)
#'
#' @export
calc_time_diff <- function(.data, x){
  time_data <- .data
  x <- as.numeric(x)

  time_data$last_update  <- as.Date(time_data$last_update)
  time_data$release_date <- as.Date(time_data$release_date)

  last_update_val <- time_data$last_update[x]
  recent_update_val <- time_data$release_date[x]

  if (is.na(last_update_val) & is.na(recent_update_val)){
    stop("Error: this video game has no listed release or update date.")
    break}
  else if (is.na(last_update_val)){
    stop("Error: this video game has no listed update date.")
    break}
  else if (is.na(recent_update_val)){
    stop("Error: this video game has no listed release date.")
    break}
  else{
    time_01 <- difftime(last_update_val, recent_update_val, units = "weeks")
    return(time_01)}}
