# server definition
# v0.1, 2019-07-16

library(shiny)

shinyServer(
  function(session, input, output) {
    callModule(choosePackage, "choosePackage1")
  }
)

