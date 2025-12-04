#' Map global game sales
#'
#' @description This function creates a leaflet map of global video game sales for individual games.
#' Categories are displayed by appearance in the data: north american sales, japanese sales, european
#' and african sales, and all other countries.
#'
#' @import dplyr
#' @importFrom readr read_csv
#' @import leaflet
#' @import sf
#' @importFrom rnaturalearth ne_countries
#'
#' @details This function takes the argument of a video game name. Ensure that the spelling of the
#' matches how it is spelled in the data. The shapefile for this data was accessed via rnaturalearth
#' data, containing polygons for each country in the world. This function combines those polygons into
#' lists, generating a column of multiple polygons outlining which countries are included in which sales
#' category.
#'
#' @param x The dataframe 'vg_long' stored in data file, function includes a merge with geospatial
#' data
#'
#' @return Prints a map using the r package leaflet and the background map CartoDB.Positron.
#'
#' @examples
#' # map_sales("Grand Theft Auto V")
#' # map_sales("Red Dead Redemption 2")
#'
#' @export
map_sales <- function(game_title) {
  # imports the transformed data needed to run this task, included in package files
  vg_long <- read_csv(file.path(getwd(), "/data/vg_long.csv"))

  # filters to JUST the game title so that we can merge the shapefiles and vg data without a crazy one to many situation
  game_sales <- vg_long |>
    filter(title == game_title)

  # in case the argument is incorrect
  if (nrow(game_sales[game_sales$title == game_title, ]) == 0) {
    stop(paste("No such game exists, check the data for the spelling"))
  }

  # ne_countries come from `rnaturalearth` which we will include in the imports section of the description file. only selecting country name and geometry info for each country's polygon.
  world <- ne_countries(scale = "medium", returnclass = "sf") |>
    select(name, geometry)

  ### why i'm doing this: our categories of vg sales are weird. we have 4 groups: one continent, one country, a combined two continents, and then everything else. no shapefile existed online with these exact categories, so the following code is me manipulating the countries shapes to build 4 polygons.

  # used lists of countries copied online from https://copypastelist.com/geography/list/list-of-countries-in-europe
  north_america <- c('Antigua and Barbuda','The Bahamas','Barbados','Belize','Canada', 'Costa Rica','Cuba','Dominica','Dominican Republic','El Salvador', 'Grenada','Guatemala','Haiti','Honduras','Jamaica','Mexico', 'Nicaragua','Panama','Saint Kitts and Nevis','Saint Lucia', 'Saint Vincent and the Grenadines','Trinidad and Tobago','United States of America')

  eur_af <- c('Albania','Andorra','Armenia','Austria','Azerbaijan','Belarus','Belgium', 'Bosnia and Herz.','Bulgaria','Croatia','Cyprus','Czechia','Denmark', 'Estonia','Finland','France','Georgia','Germany','Greece','Hungary','Iceland', 'Ireland','Italy','Kazakhstan','Kosovo','Latvia','Liechtenstein','Lithuania', 'Luxembourg','Malta','Moldova','Monaco','Montenegro','Netherlands', 'North Macedonia','Norway','Poland','Portugal','Romania', 'San Marino','Serbia','Slovakia','Slovenia','Spain','Sweden','Switzerland', 'Turkey','Ukraine','United Kingdom','Vatican City', 'Algeria','Angola','Benin','Botswana','Burkina Faso','Burundi','Cabo Verde', 'Cameroon','Central African Rep.','Chad','Comoros','Congo', 'Dem. Rep. Congo',"Côte d'Ivoire",'Djibouti','Egypt', 'Equatorial Guinea','Eritrea','eSwatini','Ethiopia','Gabon','Gambia','Ghana', 'Guinea','Guinea-Bissau','Kenya','Lesotho','Liberia','Libya','Madagascar', 'Malawi','Mali','Mauritania','Mauritius','Morocco','Mozambique','Namibia', 'Niger','Nigeria','Rwanda','São Tomé and Príncipe','Senegal','Seychelles', 'Sierra Leone','Somalia','South Africa','S. Sudan','Sudan','Tanzania', 'Togo','Tunisia','Uganda','Zambia','Zimbabwe')

  japan <- "Japan"

  # unfortunately, the rnaturalearth polygons were broken for these two countries, i assume because their polygon borders wrap around the bounds of the map. i wasn't sure how to rewrite the polgons, that's way out of my league haha, so i just removed :(
  world <- world |>
    filter(!name %in% c("Russia", "Fiji"))

  # mutating such that VG_labels are created where the groupings from the vg_chartz data set are now mirroed by our shapefile. i followed reccomendation from the prof in class and logic from https://ourcodingclub.github.io/tutorials/spatial-vector-sf/ AND  https://stackoverflow.com/questions/68806024/how-can-i-convert-a-list-of-coordinates-into-an-sf-multipolygon-file about how you can take a list of polygons and form into multipolygon list
  world_regions <- world |>
    mutate(VG_label = case_when(
      name %in% north_america ~ "na",
      name %in% eur_af ~ "pal",
      name %in% japan ~ "jp",
      TRUE ~ "other")) |>
    group_by(VG_label) |>
    summarize(geometry = st_union(st_make_valid(geometry)))

  # joining the filtered game df and the shapefile
  joined_df <- world_regions |>
    left_join(game_sales, by = "VG_label")

  # check if any sales data is missing in the joined data frame
  if (any(is.na(joined_df$total_sales)) || any(joined_df$total_sales == 0, na.rm = TRUE)) {
    stop(paste("Oops! We are missing sales data for this game (", game_title, ")"))
  }

  # color palette
  pal <- colorNumeric(palette = "YlGnBu", domain = joined_df$total_sales)

  # renaming regions for pop-up
  joined_df <- joined_df |>
    mutate(VG_label = case_when(
      VG_label == "na" ~ "North America",
      VG_label == "other" ~ "Other countries",
      VG_label == "jp" ~ "Japan",
      VG_label == "pal" ~ "Africa & Europe"))

  # finally, leaflet plot!
  map <- leaflet(joined_df) |>
    addProviderTiles("CartoDB.Positron") |>
    setView(lat = 40, lng = -40, zoom = 1) |>
    addPolygons(fillColor = ~pal(total_sales), fillOpacity = 0.7, weight = 1, popup = ~paste("<b>Game:</b> ", title, "<br>", "<b>Category:</b> ", VG_label, "<br>", "<b>Sales:</b> ", total_sales)) |>
    addLegend(
      pal = pal,
      values = joined_df$total_sales)

  return(map)
}

# maybe also a scale transformer so the numeric vals are meaningful?
