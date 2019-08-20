# Package authors
library(stringr)
library(dplyr)
library(purrr)
library(foreach)
# download.file("http://cran.R-project.org/web/packages/packages.rds",
              # "packages.rds", mode="wb")
x <- readRDS("data/packages.rds")

packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

authors <- x[, c("Package", "Author")] %>%
  as_tibble()


authors_tidy <- authors %>%
  pull(Author) %>%
  str_replace_all("\n", "") %>%
  str_replace_all("\\[aut, cre\\]", "") %>%
  str_replace_all("\\[cre, aut\\]", "") %>%
  str_replace_all("\\[aut, cph\\]", "") %>%
  str_replace_all("\\[cph, fnd\\]", "") %>%
  str_replace_all("\\[aut\\]", "") %>%
  str_replace_all("\\[cre\\]", "") %>%
  str_replace_all("\\[ctb\\]", "") %>%
  str_replace_all("\\[cph\\]", "") %>%
  str_replace_all("and ", "") %>%
  str_split(", ") %>%
  map(str_trim) %>%
  unlist

interest_authors <- authors %>%
  filter(Package %in% packages) %>%
  pull(Author) %>%
  str_replace_all("\n", "") %>%
  str_replace_all("\\[aut, cre\\]", "") %>%
  str_replace_all("\\[cre, aut\\]", "") %>%
  str_replace_all("\\[aut, cph\\]", "") %>%
  str_replace_all("\\[cph, fnd\\]", "") %>%
  str_replace_all("\\[aut\\]", "") %>%
  str_replace_all("\\[cre\\]", "") %>%
  str_replace_all("\\[ctb\\]", "") %>%
  str_replace_all("\\[cph\\]", "") %>%
  str_replace_all("and ", "") %>%
  str_split(", ") %>%
  map(str_trim) 

# Remove additional bracketed info for authors
short_list <- interest_authors %>% 
  map(~ str_split_fixed(., "\\(", 2)) %>%
# and any file paths
  map(~ .[!str_detect(., "/")] ) %>%
  map(~ .[. != ""]) %>%
  map(str_trim) %>%
  map(str_replace, "\\)", "")

count_string <- function(x){
  sum(str_count(authors_tidy, x))
}
author_counts <- foreach(i = short_list) %do% {
  sapply(i, count_string)
}

names(author_counts) <- authors  %>%
  filter(Package %in% packages) %>% 
  pull(Package)

author_counts %>%
  map_dbl(sum)
