decisionUI <- function(id){
  ns <- NS(id)

    # Inputs
    tagList(materialSwitch(inputId = ns("choice"), 
                           label = "Decision: ",
                           value = FALSE,
                           status = "success"),
            # switchInput(inputId= ns("choice"), 
            #             label = "Decision: ", 
            #             value = FALSE, 
            #             onLabel = "Accept",
            #             offLabel = "Reject", onStatus = "success", offStatus = "danger"),
            textOutput(ns("decision_out"))
    )

}
