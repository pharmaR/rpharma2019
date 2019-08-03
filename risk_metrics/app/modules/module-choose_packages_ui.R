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
                             h1(textOutput(ns("packageName"))),
                             h2(textOutput(ns("packageVersion"))),
                             h2("Overall Conclusion"),
                             textOutput(ns("conc_main")),
                             h2("Metrics"),
                             h3("Package Maintenance"),
                             textOutput(ns("conc_maint")),
                             h3("Community Usage"),
                             textOutput(ns("conc_community")),
                             h3("Testing"),
                             textOutput(ns("conc_testing"))
                             
                    ),
                    tabPanel("Maintenance",
                             fluidRow(
                               infoyesnoUI(ns("vignette")),
                               infoyesnoUI(ns("website")),
                               infoyesnoUI(ns("news")),
                               infoyesnoUI(ns("source_pub")),
                               infoyesnoUI(ns("bugtrack")),
                               infoyesnoUI(ns("license"))
                             ),
                             fluidRow(
                               box(
                                 title = "Comparison of Number of lines vs R Packages on CRAN",
                                 width = 6, 
                                 plotOutput(ns("code_lines"), height = 200)
                               ),
                               box(
                                 title = "Number of CRAN Packages by Maintainer",
                                 width = 6, height = "200px",
                                 gaugeOutput(ns("author_pks"))
                               )
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
                                   ns("conc_community"), 
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
                                   ns("conc_testing"), 
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
