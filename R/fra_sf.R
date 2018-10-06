#' Map of France
#'
#' A map of France as {sf} object. Can be used as dataset or for maps
#'
#' @format A data frame with 96 rows, 5 variables and a spatial geometry (MULTIPOLYGON):
#' \describe{
#'   \item{OBJECTID}{ID of the feature}
#'   \item{pays}{country: France}
#'   \item{region}{region name}
#'   \item{departement}{departement name}
#'   \item{id_dpt}{departement id}
#'   \item{geometry}{Simple feature geometry}
#' }
#' @source \url{GADM}
"fra_sf"
