#' run the Shiny Application
#'
#'
#' @export
#' @importFrom shiny shinyApp
#'
#' @examples
#'
#' if (interactive()) {
#'
#'   run_app()
#'
#' }
#'
run_app <- function() {
  addResourcePath("resources", system.file("resources", package = "clientapp"))
  shinyApp(ui = app_ui(), server = app_server)
}
