addComments <- function(input, output, session, pkg) {
  
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
}
