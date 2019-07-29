choosePackageUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      
      column(3,
             selectInput(ns("packagesInput"), 
                         label = "Choose a Package",
                         choices = packages),
             downloadButton(ns("report"),
                            "Generate Report"),
             sliderInput(ns("slider"), "Slider", 1, 100, 50)
             
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
