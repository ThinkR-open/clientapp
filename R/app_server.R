#' @import shiny
#' @importFrom graphics hist
#' @importFrom stats rnorm
#'
app_server <- function(input, output,session) {

  # data("database", package = "clientapp")
  database <- clientapp::database
  fra_sf <- clientapp::fra_sf
  # data("fra_sf", package = "clientapp")
  r <- reactiveValues()

  r <- callModule(mod_clients, "clients", r)
  callModule(mod_tickets, "calls")
}
