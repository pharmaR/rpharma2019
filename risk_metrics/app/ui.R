# user interface definition, module based
# v0.1, 2019-07-16

library(shiny)
library(shinythemes)

shinyUI(
  navbarPage(title = "Risk Assessment", theme = shinytheme("cerulean"),
    navbarMenu("Packages",
      tabPanel("Packages", choosePackageUI("choosePackage1"))
    ),
    navbarMenu("Assessment Criteria",
      tabPanel("Maintenance", showMetricsUI("maintenance")),
      tabPanel("Community", showMetricsUI("community")),
      tabPanel("Testing", showMetricsUI("testing"))
    )
  )
)
