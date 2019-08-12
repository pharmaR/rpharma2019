decision <- function(input, output, session, pkg) {
  
  observeEvent(input$choice,ignoreNULL = FALSE , ignoreInit = FALSE,
               {
                 package_decision[[pkg()]] <- input$choice
               })
  
                 # package_decision[[pkg()]] <- input$choice
               
  
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
