# Reproducing Environments

The goal of this section is to cover how to recreate environments that you can
trust. We will focus on determining a strategy and identifying tools to
implement that strategy for a particular use case:

1. Collaborating on a team with a Shared Baseline using a Frozen Repository
2. Safely upgrading packages with Snapshot and Restore using renv
3. Using approved packages with Validation using Docker  

**TODO** Replace this link with a PDF copy of the slides
https://docs.google.com/presentation/d/1DrrLM5igrv7UOI3eGBcXRJLf4nCLQlEmLHnzRCrVIsw/edit?usp=sharing

## Exercise 1
Where is your team currently? 
What strategy(ies) do you think are a good fit?

## Exercise 2
Open a session in R 3.5.2 and R 3.4.4

1. In each session, install the tibble package. What are the dependencies and what versions of each are installed? Why are the versions different?

2. What is the result of `options("repos")` in each session?

3. Where is the repo option set? 


## Exercise 3

Open the renv-test project:

1. Run `renv::init()` - what is added to the project? What is the result of
`renv::status()`?


2. Simulate a package upgrade. Run:
```
options(repos = c(CRAN = "https://cluster.rstudiopm.com/cran/latest"))  
install.packages("glue")
```

3. What is the new result of `renv::status()`? Run `renv::snapshot()` and `renv::status()`. What happened?


4. Explore `renv::history` , `renv::revert`, and `renv::restore`. Call
`renv::status` along the way. Can you roll back your changes?



