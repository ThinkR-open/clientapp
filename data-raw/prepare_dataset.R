# Create fake dataset using internal ThinkR package
library(dplyr)
library(fakethis)
database <- fausse_base_ticket_client(vol = 1500, n = 500, seed = 4321, split = TRUE)

database$clients <- database$clients %>%
  tidyr::fill(departement) %>%
  mutate(
    entry_year = lubridate::year(entry_date),
    age_class = cut(age, breaks = c(18, 25, 40, 55, 70, 100),
                    include.lowest = TRUE))

usethis::use_data(database, overwrite = TRUE)

# Map of France
fra_sf <- raster::getData('GADM', country = 'FRA', level = 2, path = "data-raw") %>%
  sf::st_as_sf(fra.sp) %>%
  rename(
    pays = NAME_0,
    region = NAME_1,
         departement = NAME_2,
         id_dpt = CCA_2) %>%
  mutate(n_dpt = formatC(id_dpt, width = 2, flag = "0")) %>%
  select(OBJECTID, pays, region, departement, id_dpt)

usethis::use_data(fra_sf, overwrite = TRUE)
