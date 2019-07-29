
library(shiny)
library(dplyr)
library(ggplot2)

choosePackageUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      
      column(3,
             selectInput(ns("packagesInput"), 
                         label = "Choose a Package",
                         choices = packages),
             actionButton(ns("generateReport"),
                          "Generate Report")
             #h4(textOutput(ns("packageName"))),
             
      )
    ),
    fluidRow(
      
      br(),
      
      column(3,
             h4(textOutput(ns("packageName"))),
             h4(textOutput(ns("packageVersion"))),
             textOutput(ns("concout"))
      ),
      br(),
      column(6,
             textAreaInput(
               ns("conc"), 
               # value = "ENTER PACKAGE CONCLUSION HERE",
               label = "Create Overall Conclusion",
               width = "100%",
               height = "200px",
             )
             
             
      )
    )
  )
}


choosePackage <- function(input, output, session) {
  
  output$packageName <- renderText({
    paste("Package:", input$packagesInput)
  })
  
  output$packageVersion <- renderText({
    paste("Version:", packageVersion(input$packagesInput))
  })
  
  output$concout <- renderText({
    paste(input$conc)
  })
  
}
