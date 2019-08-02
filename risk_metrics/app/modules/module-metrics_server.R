showMetrics <- function(input, output, session, filein_stub) {

  output$overview <- renderText({
    filein <- paste0(filein_stub, ".txt")
    filein_path <- "data" %>%
      file.path(filein)
    text <- read_lines(filein_path)
    paste(text)
  })
  
  output$metrics <- renderDataTable({
    filein <- paste0(filein_stub, ".csv")
    filein_path <- "data" %>%
      file.path(filein)
    text <- read_csv(filein_path)
    text
  })
  

  
}
