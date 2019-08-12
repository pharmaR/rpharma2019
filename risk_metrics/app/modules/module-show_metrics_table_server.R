showMetricsTable <- function(input, output, session, metric_labels, pkg_n, pkg_v, category) {
  
  #metric_labels <- reactiveValues()
  
  test_table <- reactive({
    metric_labels %>%
      dplyr::filter(category == "testing", 
                    package == pkg_n(),
                    version == pkg_v())
  })
  output$bing <- renderText({
    pkg_n()
  })
  output$test_table_out <- renderTable({
    test_table() %>%
      select(Parameter, Metric)
  })
}