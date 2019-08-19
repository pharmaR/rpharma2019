# global functionality and module loading
# v0.1, 2019-07-17

# Package set-up -one time only
#source("scripts/process_dcf.R")
#source("scripts/get_info.R")

library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)
library(flexdashboard)
library(DT)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2); theme_set(theme_bw(base_size = 12))



# Packages to choose from
#TODO make a CSV / DB
packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

# DESCRIPTIONs
dcf_in <- purrr::map(packages, ~ read_csv(file.path("data", paste0(., ".csv"))))

dcfs <- purrr::map(dcf_in, ~ 
                     filter(., Parameter %in% c("Author", "Maintainer", "SystemRequirements")) %>%
                     mutate(Value = replace_na(Value, "-"))
                   )
names(dcfs) <- packages

descriptions <- purrr::map_chr(dcf_in, ~ filter(., Parameter %in% c("Description")) %>% pull("Value"))
names(descriptions) <- packages

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
metrics_manual <- read_csv("data/metrics_manual.csv")
metrics_derived <- read_csv("data/metrics_derived.csv") %>%
  # Fix version appearance issue
  mutate(version = stringr::str_replace_all(version, "-", "."))
metrics <- metrics_manual %>%
  full_join(metrics_derived, by = c("package", "version"))

# Display
metrics_display <- metrics %>%
   mutate_if("is.logical", ifelse, "Yes", "No") %>%
   group_by(package, version) %>%
   gather(-package, -version, key = param, value = Metric)
# Labels
metric_labels_pre <- read_csv("data/metric_labels.csv") %>%
   full_join(metrics_display, by = "param")
# Create table of additional information
metric_extra <- read_csv("data/metric_extra.csv") %>%
  filter(!is.na(extra)) %>%
  left_join(metrics_display, by = c("extra"="param")) %>%
  rename(`Additional Information` = Metric) %>%
  select(package, version, param, `Additional Information`) 
  
metric_labels <- metric_labels_pre %>% 
  left_join(metric_extra, by = c("package", "version", "param")) %>%
  mutate(`Additional Information` = replace_na(`Additional Information`, "-")) 


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


#' Number of downloads
#' 
#' Plot of the relative number of lines of code against distribution from CRAN
#' @param value Number of lines of code in package
#' @param pkg_name Package name
#' @import ggplot2
#' @example download_plot(1000, "haven", base_data = logs_sample_all)
download_plot <- function(value, pkg_name, base_data = NULL){
  # The standard number of lines of code - as obtained by sampling CRAN
  
  ggplot() +
    #geom_line(aes(x=x_range, y=std_lines_dist)) +
    geom_density(aes(x=base_data$downloads)) +
    geom_vline(xintercept = value) +
    geom_label(label=pkg_name,
               aes(x = value, y = max(density(base_data$downloads)$y)),
               vjust = 1, hjust = 0, nudge_x = 0.01*max(base_data$downloads)) +
    xlab("Number of Downloads") +
    ylab("Density") +
    theme(axis.text.y = element_blank(),
          axis.ticks.y = element_blank())
  
}
# Downloads - typical
# Required data for CRAN comparison
load("data/logs_sample.RData")
