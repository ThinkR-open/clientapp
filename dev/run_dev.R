# .rs.api.documentSaveAll() # close and save all open file
# devtools::document(".")
attachment::att_to_description()
# devtools::install(".", upgrade = "never", quick = TRUE)
#
# options(shiny.launch.browser = TRUE); options(app.prod = TRUE); shiny::runApp(system.file("app", package = "bloomsubventions"))
# #
# # cmd <- 'options(shiny.launch.browser = TRUE); options(app.prod = TRUE); shiny::runApp(system.file("app", package = "syntime"))'
#
# rstudioapi::terminalExecute(
#   glue::glue("R -e '{cmd}'")
# )

# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
rm(list = ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()
