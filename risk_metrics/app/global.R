# global functionality and module loading
# v0.1, 2019-07-17

library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)
library(flexdashboard)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2); theme_set(theme_bw(base_size = 12))



# Packages to choose from
#TODO make a CSV / DB
packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

# DESCRIPTIONs
dcfs <- purrr::map(packages, ~ read_csv(file.path("data", paste0(., ".csv"))))
names(dcfs) <- packages

# Modules
source("modules/module-choose_packages.R")
source("modules/module-choose_packages_ui.R")
source("modules/module-choose_packages_server.R")
source("modules/module-metrics_ui.R")
source("modules/module-metrics_server.R")
source("modules/module-infoyesno_ui.R")
source("modules/module-infoyesno_server.R")
source("modules/module-add_comments_ui.R")
source("modules/module-add_comments_server.R")
source("modules/module-decision_ui.R")
source("modules/module-decision_server.R")
# source("modules/module-show_metrics_table_server.R")
# source("modules/module-show_metrics_table_ui.R")

# Temporary vars until linked to packages
metrics <- read_csv("data/metrics.csv")

# Display
metrics_display <- metrics %>%
   mutate_if("is.logical", ifelse, "Yes", "No") %>%
   group_by(package, version) %>%
   gather(-package, -version, key = param, value = Metric)
# Labels
metric_labels <- read_csv("data/metric_labels.csv") %>%
   full_join(metrics_display, by = "param")


#' Relative lines of code
#' 
#' Plot of the relative number of lines of code against distribution from CRAN
#' @param value Number of lines of code in package
#' @param pkg_name Package name
#' @import ggplot2
#' @example code_vs_pop_plot(1000, "haven")
code_vs_pop_plot <- function(value, pkg_name){
  # The standard number of lines of code - as obtained by sampling CRAN
  # TODO - sample CRAN
    x_range <- seq(0, 1, .01)
    std_lines_dist <- dbeta(x_range, 1.7,4)
    x_range <- 4000*x_range
 
  ggplot() +
    geom_line(aes(x=x_range, y=std_lines_dist)) +
    geom_vline(xintercept = value) +
    geom_label(label=pkg_name, 
               aes(x = value, y = max(std_lines_dist)),
               vjust = 1, hjust = 0, nudge_x = 0.01*max(x_range)) +
    xlab("Number of Lines of Code") +
    ylab("Density") +
    theme(axis.text.y = element_blank(),
          axis.ticks.y = element_blank())
  
}

