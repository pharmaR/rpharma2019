choosePackage <- function(input, output, session) {
  
  pkg_name <- reactive({
    input$packagesInput
  })
  pkg_version <- reactive({
    packageVersion(input$packagesInput)
  })
  
  output$packageName <- renderText({
    paste("Package:", pkg_name())
  })
  
  output$packageVersion <- renderText({
    paste("Version:", pkg_version())
  })
  
  output$conc_main <- renderText({
    paste(input$conc)
  })
  
  # Maintenance
  callModule(infoyesno, "vignette", label = "Has vignette(s)", has = has_vignette)
  callModule(infoyesno, "website", label = "Has website", has = has_website)
  callModule(infoyesno, "news", label = "Has news feed", has = has_news)
  callModule(infoyesno, "source_pub", label = "Source code maintained publicly", has = has_source_pub)
  callModule(infoyesno, "bugtrack", label = "Formal bug tracking", has = has_bugtrack)
  callModule(infoyesno, "license", label = "Company-approved license", has = approved_license)
  output$conc_maint <- renderText({
    paste(input$conc_maint)
  })
  output$code_lines <- renderPlot({
    code_vs_pop_plot(n_lines, input$packagesInput)
  })
  output$releases <- renderGauge({
    gauge(n_releases, min = 0, max = 10, gaugeSectors(
      success = c(3, 10), warning = c(1, 2), danger = c(0, 0)
    ))
  })
  output$author_pks <- renderGauge({
    gauge(n_author_pkg, min = 0, max = 30, gaugeSectors(
      success = c(6, 30), warning = c(2, 5), danger = c(0, 1)
    ))
  })
  
  # Community
  callModule(infoyesno, "cran", label = "Package available on CRAN or Bioconductor", has = on_cran)
  output$conc_community <- renderText({
    paste(input$conc_community)
  })
  
  # Testing
  callModule(infoyesno, "tests", label = "Formal testing", has = has_tests)
  output$conc_testing <- renderText({
    paste(input$conc_testing)
  })
  
  
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
                     pkg_conclusion = input$conc)
      
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
