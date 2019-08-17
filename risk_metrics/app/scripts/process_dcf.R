library(purrr)

#' Process DCF files
#' 
#' Process DCF files to extract useful information for display purposes
#' @param pkg Name of an installed R package
process_dcf <- function(pkg){
  
  # Read DCF and combine
  dcf <- read.dcf(file = system.file(package = pkg, "DESCRIPTION"))
  dcf_tib <- as_tibble(dcf) %>%
    gather(key = Parameter, value = Value)
  dcf_tib %>%
    readr::write_csv(file.path("data/DCF_processed", paste0(pkg, ".csv")))
  dcf_tib
}


# Define vars of interest
# keep_vars <- c("Title", "Description", "License", "URL", 
#                "Author", "Maintainer", "Date/Publication",
#                "Repository", "BugReports", "SystemRequirements")

create_info_csvs <- function(pkg, keep_vars){
  

  keep_var_mat <- matrix(nrow=0, ncol = length(keep_vars))
  colnames(keep_var_mat) <- keep_vars
  keep_var_tib <- as_tibble(keep_var_mat)
  
  # Read DCF and combine
  dcf <- read.dcf(file = system.file(package = pkg, "DESCRIPTION"))
  dcf_tib <- as_tibble(dcf) 
  keep_var_tib %>%
    bind_rows(dcf_tib) %>%
    # select(!!keep_vars) %>%
    gather(key = Parameter, value = Value) %>%
    readr::write_csv(file.path("data/", paste0(pkg, ".csv")))
}

# Run
packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")
dcf_tib <- foreach(i = packages) %do% {
  process_dcf(i)
}
# Get possible parameter names
params <- map(dcf_tib, ~ pull(., Parameter)) %>%
  unlist() %>%
  unique

for(i in packages){
  create_info_csvs(i, keep_vars = params)
}
