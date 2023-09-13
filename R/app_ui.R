
#' @import shiny
#' @import shinydashboard
app_ui <- function() {
  tagList(
    golem_add_external_resources(),
    golem::favicon(),
    # Define UI for application that draws a histogram
    dashboardPage(
      header = dashboardHeader(title = "Menu"), #, color = "olive"),
      sidebar = dashboardSidebar(
        # color = "olive",
        sidebarMenu(
          # id = "main_menu",
          menuItem("Clients", tabName = "clients", icon = icon("address-card")),
          menuItem("Calls", tabName = "calls", icon = icon("phone"))
        )
      ),

      # Show a plot of the generated distribution
      body = dashboardBody(
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "resources/template.css")
        ),
        # css_include(),
        tabItems(
          # Clients UI ----
          tabItem(
            tabName = "clients",
            mod_clientsUI("clients")
          ),
          tabItem(
            tabName = "calls",
            # mod_clientsUI("calls")
            mod_ticketsui("calls")
          )
        )
      )
    )
  )
}

golem_add_external_resources <- function(){

  addResourcePath("resources", system.file("resources", package = "clientapp"))

  tagList(
  # Add here all the external resources
  # If you have a custom.css in the inst/app/www
  # tags$link(rel="stylesheet", type="text/css", href="www/thinkr.css")
  # tags$script(src = "resources/js/jquery.translate.js"),
  # tags$script(src = "resources/js/main.js")
  )
}
