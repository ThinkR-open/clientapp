# the goal of this file is to keep track of all devtools/usethis
# call you make for yout project

# Feel free to cherry pick what you need and add elements

# install.packages("desc")
# install.packages("devtools")
# install.packages("usethis")

# Hide this file from build
usethis::use_build_ignore("devstuff_history.R")
usethis::use_build_ignore("dev")

# DESCRIPTION

# description ----
library(desc)
unlink("DESCRIPTION")
my_desc <- description$new("!new")
my_desc$set_version("0.0.0.9000")
my_desc$set(Package = "clientapp")
my_desc$set(Title = "A Shiny template for client database exploration")
my_desc$set(Description = "A Shiny template for client database exploration.")
my_desc$set("Authors@R",
            'c(
    person("Sebastien", "Rochette", email = "sebastien@thinkr.fr", role = c("aut", "cre"))
  )')
my_desc$set("VignetteBuilder", "knitr")
my_desc$del("Maintainer")
my_desc$del("URL")
my_desc$del("BugReports")
my_desc$write(file = "DESCRIPTION")

# Packages ----
usethis::use_roxygen_md()
usethis::use_pipe()
# If you want to use the MIT licence, code of conduct, lifecycle badge, and README
usethis::use_mit_license(name = "ThinkR")
usethis::use_readme_rmd()
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge("experimental")
usethis::use_news_md()

# For data
usethis::use_data_raw()

# For tests
usethis::use_testthat()
usethis::use_test("app")

# Dependencies
attachment::att_to_description()

# Reorder your DESC

usethis::use_tidy_description()

# Vignette
usethis::use_vignette("clientapp")
usethis::use_vignette("callsapp")
# devtools::build_vignettes()
#
# # Codecov
# usethis::use_travis()
# usethis::use_appveyor()
# usethis::use_coverage()
#
# # Test with rhub
# rhub::check_for_cran()
#
# Gitlab

# Dev
devtools::load_all()
