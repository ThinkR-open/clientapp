#' @import shiny
#' @importFrom graphics hist
#' @importFrom stats rnorm
#'
app_server <- function(input, output,session) {

  data("database", package = "clientapp")
  data("fra_sf", package = "clientapp")
  r <- reactiveValues()

  r <- callModule(mod_clients, "clients", r)
}
