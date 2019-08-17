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
  
  output$comment_ui <- renderUI({
    ns <- session$ns
    tagList(
      # Inputs
      column(width=6,
             h4(textOutput(ns("heading"))),
             textAreaInput(ns("user_text"), 
                           label = "Enter Text", 
                           placeholder = "Please enter some text.",
                           width = "100%",
                           height = "200px"),
             actionButton(ns("submit"), label = "Submit")
      ),
      column(width=6,
             h4("Report Preview"),
             textOutput(ns("text"))
      ) 
    )
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
