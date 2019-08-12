addCommentsUI <- function(id){
  ns <- NS(id)
  fluidRow(
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
}
