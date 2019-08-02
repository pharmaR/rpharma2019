choosePackageUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      column(width = 3,
             box(width = 12,
                 selectInput(ns("packagesInput"), 
                             label = "Choose a Package",
                             choices = packages),
                 downloadButton(ns("report"),
                                "Generate Report")
                 
             ),
             box(width = 12,
                 textAreaInput(
                   ns("conc"), 
                   # value = "ENTER PACKAGE CONCLUSION HERE",
                   label = "Create Overall Conclusion",
                   width = "100%",
                   height = "200px",
                 )
             )
      ),
      column(width = 9,
             tabBox(width=12,
                    title = "Risk Assessment",
                    tabPanel("Report Preview",
                             h4(textOutput(ns("packageName"))),
                             h4(textOutput(ns("packageVersion"))),
                             textOutput(ns("concout"))
                    ),
                    tabPanel("Maintenance",
                             fluidRow(
                               
                               infoyesnoUI(ns("vignette")),
                               infoyesnoUI(ns("website")),
                               infoyesnoUI(ns("news")),
                               infoyesnoUI(ns("source_pub")),
                               infoyesnoUI(ns("bugtrack"))
                             ),
                             fluidRow(
                               box(
                                 textAreaInput(
                                   ns("conc_maint"), 
                                   label = "Maintenance Notes",
                                   width = "100%",
                                   height = "200px",
                                 )
                                 
                               )
                             )
                    ),
                    tabPanel("Community Usage",
                             fluidRow(
                               infoyesnoUI(ns("cran"))
                             ),
                             fluidRow(
                               box(
                                 textAreaInput(
                                   ns("conc_maint"), 
                                   label = "Community Usage Notes",
                                   width = "100%",
                                   height = "200px",
                                 )
                                 
                               )
                               
                             )
                    ),
                    tabPanel("Testing",
                             fluidRow(infoyesnoUI(ns("tests"))),
                             fluidRow(
                               box(
                                 textAreaInput(
                                   ns("conc_maint"), 
                                   label = "Testing Notes",
                                   width = "100%",
                                   height = "200px",
                                 )
                               )
                             )
                    )
             )
      )
    )
  )
}
