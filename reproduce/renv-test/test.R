library(glue)
version <- packageDescription("glue")$Version
glue("Hello from glue version {version}")
