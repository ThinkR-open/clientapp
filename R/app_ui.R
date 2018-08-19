
#' @import shiny
#' @import shinydashboard
app_ui <- function() {
  # Define UI for application that draws a histogram
  dashboardPage(
    # ui <- semanticPage(
    # suppressDependencies("bootstrap"),
    dashboardHeader(title = "Menu"), #, color = "olive"),
    dashboardSidebar(
      # color = "olive",
      sidebarMenu(
        # id = "main_menu",
        menuItem("Clients", tabName = "clients", icon = icon("address-card")),
        menuItem("Calls", tabName = "calls", icon = icon("phone"))
      )
    ),

    # Show a plot of the generated distribution
    dashboardBody(
      # css_include(),
      tabItems(
        # Clients UI ----
        tabItem(
          tabName = "clients",
          mod_clientsUI("clients")
        ),
        tabItem(
          tabName = "calls"#,
          # mod_clientsUI("calls")
        )
      )
    )
  )
}
