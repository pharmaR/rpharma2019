choosePackageUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      column(width = 4,
             box(width = 12,
                 selectInput(ns("packagesInput"), 
                             label = "Choose a Package",
                             choices = packages),
                 downloadButton(ns("report"),
                                "Generate Report")
                 
             ),
             box(width = 12,
                 addCommentsUI(ns("conc"))
             )
      ),
      column(width = 8,
             tabBox(width=12,
                    title = "Risk Assessment",
                    tabPanel("Report Preview",
                             h1(textOutput(ns("packageName"))),
                             h2(textOutput(ns("packageVersion"))),
                             h2("Overall Conclusion"),
                             textOutput(ns("conc_text")),
                             h2("Metrics"),
                             h3("Package Maintenance"),
                             textOutput(ns("conc_maint_text")),
                             h3("Community Usage"),
                             textOutput(ns("conc_community_text")),
                             h3("Testing"),
                             textOutput(ns("conc_testing_text"))
                             
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
                                 title = "Releases in past 18 Months",
                                 width = 4, height = "200px",
                                 gaugeOutput(ns("releases"))
                               ),
                               box(
                                 title = "Number of CRAN Packages by Maintainer",
                                 width = 4, height = "200px",
                                 gaugeOutput(ns("author_pks"))
                               )
                             ),
                             fluidRow(
                               
                               box(
                                 title = "Comparison of Number of lines vs R Packages on CRAN",
                                 width = 6, 
                                 plotOutput(ns("code_lines"), height = 200)
                               )
                               
                             ),
                             br(),
                             # fluidRow(
                             #   box(
                             #     width = 12,
                                 addCommentsUI(ns("conc_maint"))
                             #   )   
                             # )
                             
                    ),
                    tabPanel("Community Usage",
                             fluidRow(
                               tagList(infoyesnoUI(ns("cran")))
                             ),
                             br(),
                             # fluidRow(
                               # box(
                                 # width = 12,
                                 addCommentsUI(ns("conc_community"))
                               # )
                               
                             # )
                    ),
                    tabPanel("Testing",
                             fluidRow(
                               infoyesnoUI(ns("tests")),
                               box(
                                 title = "Test Coverage",
                                 width = 4, height = "200px",
                                 gaugeOutput(ns("test_coverage"))
                               )
                             ),
                             br(),
                             # fluidRow(
                               # box(
                                 # width = 12,
                                 addCommentsUI(ns("conc_testing"))
                               # )
                             # )
                    )
             )
      )
    )
  )
}
