decision <- function(input, output, session, pkg) {
  
  # Only update when user says to
  observeEvent(input$choice,
               {
                 package_decision[[pkg()]] <- input$choice
               })
  

  
  # text output
  # package_decision[[pkg()]] <- reactive({
  #   input$choice
  # })
  
  package_decision <- reactiveValues()

  # return(
  #   reactive(package_decision)
  # )
  output$packageDecision <- renderText({
    package_decision[[pkg()]]
  })
  
}
