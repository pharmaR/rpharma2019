decision <- function(input, output, session, pkg) {
  
  # Respond to user choice
  observeEvent(input$choice,ignoreNULL = FALSE , ignoreInit = FALSE,
               {
                 package_decision[[pkg()]] <- input$choice
               })
  
  # Refresh input text when package changes
  observeEvent(pkg(),
               {
                 updateMaterialSwitch(
                   session, 
                   "choice", 
                   value= ifelse(is.null(package_decision[[pkg()]]), FALSE, package_decision[[pkg()]]))
               })
  

  package_decision <- reactiveValues()

  # output$decision_out <- renderText({
  #   ifelse(package_decision[[pkg()]], "Accept", "Reject")
  # })
  # 
  #output$decision_switch
  return(
    reactive(package_decision)
  )
  
}
