# riskmetric
devtools::load_all()

packages <- c("haven", "dplyr", "broom", "lme4", "RBesT", "foreach")

library(dplyr)
package_tbl <- packages %>%
  pkg_ref() %>%
  as_tibble()

# Assess
package_assess <- package_tbl %>%
  assess()

package_score <- package_assess %>%
  score()

