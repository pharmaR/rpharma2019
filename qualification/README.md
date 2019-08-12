# Qualification

This section of the course will introduce you to package testing and describe
how to write tests for groups of packages in an environment.

**TODO** Remove link and add pdf copy of slides
https://docs.google.com/presentation/d/1EtTdXFHcvaDj_BUBioYYNk6-JAV_tbTU-5E8_bldn2Q/edit?usp=sharing

## Exercise 1

1. Re-open our `helloworld` package project. Run `usethis::use_testthat()`. What happened?

2. Run `usethis::use_test(“hello”)`

3. Copy in:

```
test_that("hello works", {
  expect_equal(hello("world"), "Hello, world!")
})
```

4. Run test: `test_file("tests/testthat/test-hello.R")`

