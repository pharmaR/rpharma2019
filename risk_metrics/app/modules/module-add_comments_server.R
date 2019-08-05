addComments <- function(input, output, session) {
  
  # Only update when user says to
  observeEvent(input$submit,
               {
                 text_reactive[[input$pkg]] <- input$user_text
               })
  

  text_reactive <- reactiveValues()
  
  # text output
  output$text <- renderText({
    text_reactive[[input$pkg]]
  })
}

shinyApp(ui = ui, server = server)