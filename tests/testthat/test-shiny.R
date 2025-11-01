library(testthat)
library(pixture)
library(shiny)

testthat::context("launchApp")

test_that("Incorrect input", {
  expect_error(launchApp(app = "Bla"))
})
