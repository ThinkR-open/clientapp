#' Customer by departement
#'
#' @param x database
#' @param priorite priorite
#' @param age_class age_class
#'
#' @importFrom dplyr filter count arrange desc
#'
#' @export
client_by_dpt <- function(x, priorite, age_class) {
  if (!missing(priorite) && priorite != "All") {
    x <- x %>%
      filter(priorite == !!priorite)
  }
  if (!missing(age_class) && age_class != "All") {
    x <- x %>%
      filter(age_class == !!age_class)
  }
  x %>%
    count(region, id_dpt) %>%
    arrange(desc(n))
}
