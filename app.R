# rsconnect::appDependencies
if (!require(pkgload)) { install.packages("pkgload", repos = "https://cloud.r-project.org"); require(pkgload)}
pkgload::load_all()
options( "golem.app.prod" = TRUE)
# devtools::install_version("rgeos", version = "0.3-28", repos = "http://cran.us.r-project.org")
# run_app()

# addResourcePath("resources", system.file("resources", package = "clientapp"))
shinyApp(ui = app_ui(), server = app_server)

