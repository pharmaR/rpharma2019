library(purrr)
library(foreach)
library(lubridate)
packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

dcf_in <- map(packages, ~ read_csv(file.path("data", paste0(., ".csv")))) 
# Collapse info
dcf_pkg <- map(dcf_in, ~ spread(., key = Parameter, value = Value)) 
pkg_info <- do.call(bind_rows, dcf_pkg) %>%
  rename(package = Package,
         version = Version)

pkg_info_derived <- pkg_info %>%
  mutate(on_cran = ifelse(Repository == "CRAN", TRUE, FALSE),
         has_bugtrack = ifelse(!is.na(BugReports), TRUE, FALSE),
         date_pub_pkg = ymd_hms(`Date/Publication`),
         months_version = floor(as.numeric(difftime(today(), date_pub_pkg, "days")) %% 30))

write_csv(pkg_info_derived, "data/metrics_derived.csv")
