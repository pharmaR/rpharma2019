library(glue)
library(remotes)
version <- packageDescription("glue")$Version
glue("Hello from glue version {version}")
