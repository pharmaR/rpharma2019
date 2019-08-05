
addCommentsUI <- function(id, pkgs){
  ns <- NS(id)
  tagList(
    # Inputs
    selectInput(ns("pkg"), "Package",
                choices = pkgs), #LETTERS[1:3]),
    
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
