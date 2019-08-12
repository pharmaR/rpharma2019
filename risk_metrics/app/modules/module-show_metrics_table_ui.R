showMetricsTableUI <- function(id){
  ns <- NS(id)
  tagList(
    textOutput(ns("bing")),
    tableOutput(ns("test_table_out"))
  
  )
}
