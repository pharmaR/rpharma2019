# Packages 101

R packages are the heart of the R ecosystem. This section of the course
will introduce you to:

1. The structure of an R package
2. The way R packages are distributed through a *repository*
3. The organization of installed packages in a *library*

## Exercise 1

1. Run `usethis::create_package("~/helloworld")`. What does the skeleton of the package look like?


2. Run `usethis::use_r("hello")` and then copy this:

```
hello <- function(name){ sprintf("Hello %s!", name)} 
```

3. Build the package by clicking "Build", "Install and Restart" (upper-right hand RStudio pane). Then run the following in the console:

```
library(helloworld)
hello("Sean")
```

## Exercise 2

1. Run `.libPaths()`

2. Can you find the installed version of the `helloworld` package? 

3. How does it compare to the source version?

4. What else is in your library? Hint:

```
fs::dir_ls(.libPaths())
```

## Exercise 3

1. In our package project, run `usethis::use_package("glue")`

2. Change our function in `R/hello.R` to: 

```
hello <- function(name){glue::glue("Hello, {name}!")}
```

3. Re-build our package and try out our new function.

4. What version of `glue` is used? Why?


