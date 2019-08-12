addComments <- function(input, output, session, pkg, heading) {
  
  # Only update when user says to
  observeEvent(input$submit,
               {
                 text_reactive[[pkg()]] <- input$user_text
               })
  

  text_reactive <- reactiveValues()
  
  # text output
  output$text <- renderText({
    text_reactive[[pkg()]]
  })
  
  output$heading <- renderText({
    heading
  })
  
  return(
    reactive(text_reactive)
  )
  
}
