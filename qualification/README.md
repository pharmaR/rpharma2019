# Qualification

This section of the course will introduce you to package testing and describe
how to write tests for groups of packages in an environment.

## Exercise 1

1. Re-open our `helloworld` package project. Run `usethis::use_testthat()`. What happened?

2. Run `usethis::use_test(“hello”)`

3. Copy in:

```
test_that("hello works", {
  expect_equal(hello("world"), "Hello, World!")
})
```

4. Run test: 

```
library(helloworld)
test_file("tests/testthat/test-hello.R")
```

Why is the test failing? Propose a fix either to your expectation or your code!

