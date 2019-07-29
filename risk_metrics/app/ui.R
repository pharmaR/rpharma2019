# user interface definition, module based
# v0.1, 2019-07-16

library(shiny)
library(shinythemes)

shinyUI(
  navbarPage(title = "Risk Assessment", theme = shinytheme("cerulean"),
    navbarMenu("Packages",
      tabPanel("Samples", choosePackageUI("choosePackage1"))
    ),
    navbarMenu("Assessment Criteria",
      tabPanel("Maintenance", choosePackageUI("choosePackage2")),
      tabPanel("Community", choosePackageUI("choosePackage3")),
      tabPanel("Testing", choosePackageUI("choosePackage4"))
    )
  )
)
