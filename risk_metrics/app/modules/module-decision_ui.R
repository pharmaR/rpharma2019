decisionUI <- function(id){
  ns <- NS(id)
  fluidRow(
    # Inputs
    column(width=6,
           materialSwitch(inputId = ns("choice"), 
                          label = "Accept?", 
                          value = FALSE),
           textOutput(ns("packageDecision"))
    )
  )
}
