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
  callModule(infoyesno, "vignette", label = "Has vignette(s)", has = TRUE)
  callModule(infoyesno, "website", label = "Has website", has = TRUE)
  callModule(infoyesno, "news", label = "Has news feed", has = FALSE)
  callModule(infoyesno, "source_pub", label = "Source code maintained publicly", has = TRUE)
  callModule(infoyesno, "bugtrack", label = "Formal bug tracking", has = FALSE)
  output$conc_maint <- renderText({
    paste(input$conc_maint)
  })
  
  # Community
  callModule(infoyesno, "cran", label = "Package available on CRAN or Bioconductor", has = FALSE)
  output$conc_community <- renderText({
    paste(input$conc_community)
  })
  
  # Testing
  callModule(infoyesno, "tests", label = "Formal testing", has = FALSE)
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
