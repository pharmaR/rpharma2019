addCommentsUI <- function(id){
  ns <- NS(id)
  fluidRow(
    # Inputs
    column(width=6,
           textAreaInput(ns("user_text"), 
                         label = "Conclusion", 
                         placeholder = "Please enter some text.",
                         width = "100%",
                         height = "200px"),
           actionButton(ns("submit"), label = "Submit")
    ),
    column(width=6,
           textOutput(ns("text"))
    )
  )
}
