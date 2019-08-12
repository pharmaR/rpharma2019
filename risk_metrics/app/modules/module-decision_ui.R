decisionUI <- function(id){
  ns <- NS(id)

    # Inputs
    tagList(materialSwitch(inputId = ns("choice"), 
                           label = "Decision: ", 
                           value = FALSE),
            textOutput(ns("decision_out"))
    )

}
