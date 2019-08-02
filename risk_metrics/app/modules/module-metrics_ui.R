showMetricsUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    column(12,
      textOutput(ns("overview")),
      dataTableOutput(ns("metrics"))
    )
  )
}
