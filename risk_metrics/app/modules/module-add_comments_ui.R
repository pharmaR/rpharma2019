
addCommentsUI <- function(id){
  ns <- NS(id)
  tagList(
    # Inputs
    textAreaInput(ns("user_text"), 
                  label = "Conclusion", 
                  placeholder = "Please enter some text.",
                  width = "100%",
                  height = "200px"),
    actionButton(ns("submit"), label = "Submit"),
    
    # Visual output
    textOutput(ns("text"))
  )
}
