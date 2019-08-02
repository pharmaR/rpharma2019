showMetricsUI <- function(id) {
  ns <- NS(id)
    fluidRow(
      box(width = 3,
          textOutput(ns("overview"))),
      box(width = 9,
          dataTableOutput(ns("metrics")))
  )
}
