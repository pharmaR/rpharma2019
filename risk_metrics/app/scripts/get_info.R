library(purrr)
library(foreach)
library(lubridate)
library(stringr)

packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

dcf_in <- map(packages, ~ read_csv(file.path("data", paste0(., ".csv")))) 
# Collapse info
dcf_pkg <- map(dcf_in, ~ spread(., key = Parameter, value = Value)) 
pkg_info <- do.call(bind_rows, dcf_pkg) %>%
  rename(package = Package,
         version = Version)

# Number of lines of code
source("scripts/count_lines.R")
package_dir <- "../package_source"
dir_packages <- list.files(package_dir, full.names = TRUE)
counts <- map_dbl(dir_packages, n_lines_dir)
names(counts) <- dir_packages %>%
  str_replace("../package_source/", "")
counts_df <- counts %>%
  tibble::enframe(name = "package", value = "n_lines")

# Vignettes
vignette_info <- map_chr(packages, ~ getVignetteInfo(.) %>% as_tibble %>% pull(Title) %>% paste(collapse="; "))
vignettes <- tibble(package = packages, vignette_names = vignette_info)


pkg_info_derived <- pkg_info %>%
  left_join(counts_df, by = "package") %>% # TODO get version into this or will fail
  left_join(vignettes, by = "package") %>% # TODO get version into this or will fail 
  mutate(on_cran = ifelse(Repository == "CRAN", TRUE, FALSE),
         has_bugtrack = ifelse(!is.na(BugReports), TRUE, FALSE),
         has_website = ifelse(!is.na(URL), TRUE, FALSE),
         date_pub_pkg = ymd_hms(`Date/Publication`),
         months_version = floor(as.numeric(difftime(today(), date_pub_pkg, "days")) %% 30),
         has_vignette = !is.na(vignette_names)) 


write_csv(pkg_info_derived, "data/metrics_derived.csv")
