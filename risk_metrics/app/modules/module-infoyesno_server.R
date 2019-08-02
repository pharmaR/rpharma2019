infoyesno <- function(input, output, session, label, has) {
  output$yesno <- renderInfoBox({
    ns <- session$ns
    infoBox(
      label, ifelse(has, "Yes", "No"), 
      width = 3,
      icon = icon(ifelse(has, "thumbs-up", "thumbs-down"), lib = "glyphicon"),
      color = ifelse(has, "green", "red"),
      fill = TRUE
    )
  })
}