# global functionality and module loading
# v0.1, 2019-07-17

library(shiny)
library(readr)
library(dplyr)
library(stringr)
library(ggplot2)

# Packages to choose from
#TODO make a CSV / DB
packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

# Modules
source("modules/module-choose_packages.R")

