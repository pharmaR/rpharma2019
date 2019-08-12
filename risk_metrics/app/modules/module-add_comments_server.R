addComments <- function(input, output, session, pkg, heading) {
  
  # Only update when user says to
  observeEvent(input$submit,
               {
                 text_reactive[[pkg()]] <- input$user_text                 
               })

  # Refresh input text when package changes
  observeEvent(pkg(),
               {
                 updateTextInput(
                   session, 
                   "user_text", 
                   value= ifelse(is.null(text_reactive[[pkg()]]), "", text_reactive[[pkg()]]),
                   placeholder = "Please enter some text.")
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
