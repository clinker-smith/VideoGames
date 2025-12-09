#' Graph global developer sales
#'
#' @description This function creates a column plot of global game sales for specific developers
#' by region.
#'
#' @import dplyr
#' @import ggplot2
#'
#' @details This function takes the argument of a developer name. Ensure that the spelling of the
#' matches how it is spelled in the data. The function will return a column plot showing the game
#' sales for the 4 regions in our data
#'
#' @param The dataframe 'vgchartz' stored in data file
#'
#' @return Prints a plor using the R package ggplot2 and a Brewer color palette.
#'
#' @examples
#' # graph_developers("Konami")
#' # graph_developers("Naughty Dog"))
#'
#' @export
graph_developers <- function(dev_name){

  vgchartz_long <- vgchartz |>
    pivot_longer(cols = c(na_sales, jp_sales, pal_sales, other_sales), names_to = "region", values_to = "sales")

  vgchartz_dev_sales <- vgchartz_long |> group_by(developer, region) |> summarise(total_sales = sum(sales, na.rm = TRUE)) |>
    filter(developer == dev_name)


  vgchartz_dev_sales <- vgchartz_dev_sales |>
    mutate(region = case_when(
      region == "pal_sales" ~ "European and African",
      region == "other_sales" ~ "Other Countries",
      region == "na_sales" ~ "North American",
      region == "jp_sales" ~ "Japanese"))


  vgchartz_dev_sales |>
    ggplot(aes(x=reorder(region, total_sales),
               y=total_sales,
               fill=region)) +
    geom_col() +
    coord_flip() +
    labs(x="Sales Region",
         y="Total Sales (in millions, USD)",
         title=paste0(dev_name, "'s Total Game Sales by Region")) +
    scale_fill_brewer(palette = "Set2") +
    theme_minimal() +
    theme(legend.position = "none")

}

