choosePackageUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      column(width = 4,
             box(width = 12,
                 selectInput(ns("packagesInput"), 
                             label = "Choose a Package",
                             choices = packages),
                 decisionUI(ns("accept_or_reject")),
                 box(width=12,
                     addCommentsUI(ns("conc"))
                 ),
                 br(),
                 downloadButton(ns("report"),
                                "Generate Report")
             )
      ),
      column(width = 8,
             tabBox(width=12,
                    title = "Risk Assessment",
                    tabPanel("Report Preview",
                             h1(textOutput(ns("packageName"))),
                             h2(textOutput(ns("packageVersion"))),
                             textOutput(ns("desc_desc")),
                             h2(textOutput(ns("decision_out"))),
                             tableOutput(ns("desc_info")),
                             h2("Overall Conclusion"),
                             textOutput(ns("conc_text")),
                             h2("Details"),
                             h3("Package Maintenance"),
                             tableOutput(ns("maint_table_out")),
                             textOutput(ns("conc_maint_text")),
                             h3("Community Usage"),
                             tableOutput(ns("comm_table_out")),
                             textOutput(ns("conc_community_text")),
                             h3("Testing"),
                             tableOutput(ns("test_table_out")),
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
                             addCommentsUI(ns("conc_maint"))
                             
                             
                    ),
                    tabPanel("Community Usage",
                             fluidRow(
                               tagList(infoyesnoUI(ns("cran")))
                             ),
                             br(),
                             box(
                               title = "Package Maturity (months)",
                               width = 4, height = "200px",
                               gaugeOutput(ns("maturity_pkg"))
                             ),
                             box(
                               title = "Version Maturity (months)",
                               width = 4, height = "200px",
                               gaugeOutput(ns("maturity_version"))
                             ),
                             box(
                               title = "Number of Reverse Dependencies",
                               width = 4, height = "200px",
                               gaugeOutput(ns("reverse_depends"))
                             ),
                             box(
                               title = "Comparison of Number of Downloads vs R Packages on CRAN",
                               width = 6, 
                               plotOutput(ns("n_downloads"), height = 200)
                             ),
                             addCommentsUI(ns("conc_community"))
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
                             addCommentsUI(ns("conc_testing"))
                    )
             )
      )
    )
  )
}
