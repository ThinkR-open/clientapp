#' @importFrom plotly plotlyOutput
#' @importFrom DT DTOutput
#' @importFrom leaflet leafletOutput
#' @importFrom dplyr pull
mod_clientsUI <- function(id) {
  ns <- NS(id)
  fluidRow(
    box(
      width = 12,
      title = "Clients database",
      collapsible = TRUE,
      collapsed = TRUE,
      solidHeader = FALSE,
      status = "warning",
      DTOutput(ns("base_client"))
    ),
    box(
      width = 12,
      title = "Customer database exploration",
      collapsible = TRUE,
      collapsed = FALSE,
      solidHeader = TRUE,
      status = "primary",
      column(
        width = 6,
        plotlyOutput(ns("entry_level"))
      ),
      column(
        width = 6,
        plotlyOutput(ns("fidelity"))
      )
    ),
    box(
      width = 12,
      title = "Map exploration",
      collapsible = TRUE,
      collapsed = FALSE,
      solidHeader = TRUE,
      status = "primary",
      column(
        width = 3,
        selectInput(ns("priority"), label = "Priority",
                    choices = c("All", levels(pull(database$clients, priority)))
        ),
        selectInput(ns("age_class"), label = "Age class",
                    choices = c("All",
                                levels(pull(database$clients, age_class)))
        )
      ),
      column(
        width = 9,
        leafletOutput(ns("client_dept"))
      )
      )
  )
}

#' @importFrom dplyr mutate count left_join
#' @importFrom ggplot2 ggplot geom_bar aes scale_fill_manual theme_bw geom_point geom_line xlab ylab geom_violin scale_fill_viridis_d scale_color_viridis_d
#' @importFrom plotly ggplotly renderPlotly
#' @importFrom DT datatable renderDT
#' @importFrom leaflet leaflet renderLeaflet colorNumeric addTiles addPolygons addLegend labelFormat
#' @importFrom sf st_as_sf
mod_clients <- function(input, output, session, r) {
  ns <- session$ns

  output$base_client <- renderDT({
    message(ns("output$base_client"))
    datatable(database$clients,
              options = list(scrollX = TRUE))
  })

  output$entry_level <- renderPlotly({
    message(ns("output$entry_level"))
    pr_level <- c("Bronze", "Silver", "Gold", "Platinium")
    colpal <- c("#965A38", "#A8A8A8", "#D9A441", "#3B3B1D")
    names(colpal) <- pr_level

    g <- database$clients %>%
      mutate(priority = factor(priority, levels = rev(pr_level))) %>%
      count(entry_year, priority) %>%
      ggplot() +
      geom_bar(aes(x = entry_year, y = n, fill = priority),
               stat = "identity") +
      scale_fill_manual(values = colpal) +
      xlab("Entry year") +
      ylab("Amount of customers") +
      theme_bw()

    plotly::ggplotly(g)
  })

  output$fidelity <- renderPlotly({
    message(ns("output$fidelity"))
    g <- ggplot(database$clients) +
      aes(age_class, fidelity_points) +
      geom_violin(aes(fill = age_class),
                  draw_quantiles = 0.5, scale = "count",
                  alpha = 0.75, colour = "black") +
      # geom_violin(aes(colour = age_class),
      #             draw_quantiles = 0.5, scale = "count",
      #             alpha = 1, fill = NA) +
      # geom_dotplot(binaxis = "y", stackdir = "centerwhole",
      #              binwidth = 60,
      #              color = "grey20",
      #              alpha = 0.7,
      #              dotsize = 1) +
      # scale_y_log10() +
      scale_fill_viridis_d(guide = FALSE) +
      scale_color_viridis_d(guide = FALSE) +
      xlab("Age class") +
      ylab("Points of fidelity") +
      theme_bw()

    plotly::ggplotly(g)
  })

  output$client_dept <- renderLeaflet({
    message(ns("output$client_dept"))
    all_by_dpt <- fra_sf %>%
      left_join(client_by_dpt(database$clients, priority = input$priority, age_class = input$age_class),
                by = c("region", "id_dpt")) %>%
      st_as_sf()

    my_pal <- colorNumeric(viridis::viridis(n = 30, direction = -1), domain = all_by_dpt$n)
    my_pal_rev <- colorNumeric(viridis::viridis(n = 30, direction = 1), domain = all_by_dpt$n)

    leaflet(all_by_dpt) %>%
      addTiles() %>%
      addPolygons(fillColor = ~my_pal(n), fillOpacity = 0.75,
                  color = "#474747", weight = 1,
                  label = paste0(
                    all_by_dpt$departement, " (",
                    ifelse(is.na(all_by_dpt$n),
                           0,all_by_dpt$n), ")")
      ) %>%
      addLegend(position = "topright", pal = my_pal_rev,
                title = "Nb of clients",
                values = ~n, bins = 4,
                opacity = 0.75, na.label = "0",
                labFormat = labelFormat(
                  transform = function(x) rev(x))
      )
    })
}
