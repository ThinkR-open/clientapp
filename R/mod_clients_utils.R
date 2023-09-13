#' Customer by departement
#'
#' @param x database
#' @param priority priority
#' @param age_class age_class
#'
#' @importFrom dplyr filter count arrange desc
#'
#' @export
client_by_dpt <- function(x, priority, age_class) {
  if (!missing(priority) && priority != "All") {
    x <- x %>%
      filter(priority == !!priority)
  }
  if (!missing(age_class) && age_class != "All") {
    x <- x %>%
      filter(age_class == !!age_class)
  }
  x %>%
    count(region, id_dpt) %>%
    arrange(desc(n))
}
