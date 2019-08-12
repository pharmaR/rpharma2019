choosePackage <- function(input, output, session) {
  
  pkg_name <- reactive({
    input$packagesInput
  })
  pkg_version <- reactive({
    packageVersion(input$packagesInput)
  })
  
  # text output
  output$text <- renderText({
    text_reactive[[pkg()]]
  })
  

  # Extract DESCRIPTION info for overview
  desc_info <- reactive({
    dcfs[[pkg_name()]]
  })
  output$desc_info <- renderTable(desc_info())
  
  # Package info
  pkg_info <- reactive({
    metrics %>%
      filter(package == pkg_name(),
             version == pkg_version())
  })
  output$packageName <- renderText({
    paste("Package:", pkg_name())
  })
  
  output$packageVersion <- renderText({
    paste("Version:", pkg_version())
  })
  
  
  # Maintenance
  has_vignette <- reactive({
    pull(pkg_info(), has_vignette)
  })
  has_website <- reactive({
    pull(pkg_info(), has_website)
  })
  has_news <- reactive({
    pull(pkg_info(), has_news)
  })
  has_source_pub <- reactive({
    pull(pkg_info(), has_source_pub)
  })
  has_bugtrack <- reactive({
    pull(pkg_info(), has_bugtrack)
  })
  approved_license <- reactive({
    pull(pkg_info(), approved_license)
  })
  n_releases <- reactive({
    pull(pkg_info(), n_releases)
  })
  n_lines <- reactive({
    pull(pkg_info(), n_lines)
  })
  n_author_pkg <- reactive({
    pull(pkg_info(), n_author_pkg)
  })
  
  # Maintenance report display
  maint_table <- reactive({
    metric_labels %>%
      dplyr::filter(category == "maintenance", 
                    package == pkg_name(),
                    version == pkg_version()) %>%
      select(Parameter, Metric)
  })
  output$maint_table_out <- renderTable({
    maint_table() 
  })
  
  # Community
  on_cran <- reactive({
    pull(pkg_info(), on_cran)
  })
  #TODO Add others
  # Community report display
  comm_table <- reactive({
    metric_labels %>%
      dplyr::filter(category == "community", 
                    package == pkg_name(),
                    version == pkg_version()) %>%
      select(Parameter, Metric)
  })
  output$comm_table_out <- renderTable({
    comm_table() 
  })
  
  # Testing
  has_tests <- reactive({
    pull(pkg_info(), has_tests)
  })
  test_coverage <- reactive({
    pull(pkg_info(), test_coverage)
  })
  
  # Test report display
  test_table <- reactive({
    metric_labels %>%
      dplyr::filter(category == "testing", 
                    package == pkg_name(),
                    version == pkg_version()) %>%
      select(Parameter, Metric)
  })
  output$test_table_out <- renderTable({
    test_table() 
  })
  
    
  
  # Overall
  # User Input
  conc_text <- callModule(addComments, "conc", pkg = pkg_name, heading = "Package Conclusion")
  output$conc_text <- renderText(conc_text()[[pkg_name()]])
  
  pkg_dec <- callModule(decision, "accept_or_reject", pkg = pkg_name)
  output$decision_out <- renderText({
    ifelse(pkg_dec()[[pkg_name()]], "Decision: Accept", "Decision: Reject")
  })
  
  
  # Maintenance
  callModule(infoyesno, "vignette", label = "Has vignette(s)", has = has_vignette)
  callModule(infoyesno, "website", label = "Has website", has = has_website)
  callModule(infoyesno, "news", label = "Has news feed", has = has_news)
  callModule(infoyesno, "source_pub", label = "Source code maintained publicly", has = has_source_pub)
  callModule(infoyesno, "bugtrack", label = "Formal bug tracking", has = has_bugtrack)
  callModule(infoyesno, "license", label = "Company-approved license", has = approved_license)

  output$code_lines <- renderPlot({
    code_vs_pop_plot(n_lines(), input$packagesInput)
  })
  output$releases <- renderGauge({
    gauge(n_releases(), min = 0, max = 10, gaugeSectors(
      success = c(3, 10), warning = c(1, 2), danger = c(0, 0)
    ))
  })
  output$author_pks <- renderGauge({
    gauge(n_author_pkg(), min = 0, max = 30, gaugeSectors(
      success = c(6, 30), warning = c(2, 5), danger = c(0, 1)
    ))
  })
  # User input
  conc_maint_text <- callModule(addComments, "conc_maint", pkg = pkg_name, heading = "Maintenance Summary")
  output$conc_maint_text <- renderText(conc_maint_text()[[pkg_name()]])
  
  # Community
  callModule(infoyesno, "cran", label = "Package available on CRAN or Bioconductor", has = on_cran)
  # User input
  conc_community_text <- callModule(addComments, "conc_community", pkg = pkg_name, heading = "Community Summary")
  output$conc_community_text <- renderText(conc_community_text()[[pkg_name()]])
  
  # Testing
  callModule(infoyesno, "tests", label = "Formal testing", has = has_tests)
  output$test_coverage <- renderGauge({
    gauge(test_coverage(), min = 0, max = 100, gaugeSectors(
      success = c(70, 100), warning = c(40, 69), danger = c(0, 39)
    ))
  })
  # User input
  conc_testing_text <- callModule(addComments, "conc_testing", pkg = pkg_name, heading = "Testing Summary")
  output$conc_testing_text <- renderText(conc_testing_text()[[pkg_name()]])
  
  # Report
  output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "report.html",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("reports/template/report.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(pkg_name = pkg_name(),
                     pkg_version = pkg_version(),
                     pkg_conclusion = conc_text(),
                     pkg_maint = conc_maint_text(),
                     pkg_community = conc_community_text(),
                     pkg_testing = conc_testing_text(),
                     pkg_accept = "Reject")
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    }
  )
  
}
