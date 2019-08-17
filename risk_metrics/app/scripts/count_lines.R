#' Lines of code
#' 
#' Read all the code in a directory
#' @param dir Package directory which contains an 'R' subdirectory .
#' @import foreach
#' @import stringr
n_lines_dir <- function(dir){
  
  scripts <- list.files(file.path(dir, "R"), full.names = TRUE)
  
  all_code <- foreach(script = scripts, .combine = "c") %do% {
    this_script <- readLines(script)
    # Find missing and comment lines
    trimmed <- str_trim(this_script)
    # Comments
    comment_line <- trimmed %>% str_detect("^#")
    blank_line <- trimmed == ""
    trimmed[!(comment_line | blank_line)] %>%
      length
  }
  
  n_lines <- sum(all_code)
  n_lines
}




