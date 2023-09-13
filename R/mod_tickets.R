# Module UI
#' @title   mod_ticketsui and mod_tickets
#' @description  A shiny Module that ...
#'
#' @param id shiny id
#'
#' @export
#' @importFrom shiny NS tagList
mod_ticketsui <- function(id){
  ns <- NS(id)
  tagList(
    valueBoxOutput(ns("awaiting"), width = 4)
  )
}

# Module server
#' mod_tickets server function
#'
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @importFrom dplyr case_when left_join mutate count filter
#' @importFrom shinydashboard renderValueBox valueBox
#'
#' @export
#' @rdname mod_ticketsui

mod_tickets <- function(input, output, session){
  ns <- session$ns

  ticket_complete <- database$tickets %>%
    left_join(database$clients, by = "num_client")

  state_reduce <- ticket_complete %>%
    mutate(state_reduce = case_when(
      grepl("Attente", state) ~ "Awaiting",
      state == "Termin\u00E9" ~ "Done",
      TRUE ~ "Proceeding"
    )) %>%
    count(state_reduce) %>%
    mutate(pc = n/sum(n))

  output$awaiting <- renderValueBox({
    awaiting <- state_reduce %>%
      filter(state_reduce == "Awaiting")

    valueBox(
      value = awaiting %>% pull(n),
      subtitle = "Awaiting",
      icon = icon("area-chart"),
      color = if (awaiting %>% pull(pc) >= 0.30) "red" else "aqua"
    )
  })
}

## To be copied in the UI
# mod_ticketsui("m1")

## To be copied in the server
# callModule(mod_tickets, "m1")

