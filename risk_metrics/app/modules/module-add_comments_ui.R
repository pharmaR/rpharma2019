addCommentsUI <- function(id){
  ns <- NS(id)
  fluidRow(
    uiOutput(ns("comment_ui"))
  )
}
