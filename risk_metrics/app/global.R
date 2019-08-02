# global functionality and module loading
# v0.1, 2019-07-17

library(shiny)
library(shinydashboard)
library(shinythemes)
library(DT)
library(readr)
library(dplyr)
library(stringr)
library(ggplot2)

# Packages to choose from
#TODO make a CSV / DB
packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

# Modules
source("modules/module-choose_packages.R")
source("modules/module-choose_packages_ui.R")
source("modules/module-choose_packages_server.R")
source("modules/module-metrics_ui.R")
source("modules/module-metrics_server.R")
source("modules/module-infoyesno_ui.R")
source("modules/module-infoyesno_server.R")

# Temporary vars until linked to packages
has_vignette <- TRUE
has_website <- FALSE
has_news <- FALSE
has_source_pub <- TRUE
has_bugtrack <- TRUE

has_cran <- TRUE

has_tests <- FALSE