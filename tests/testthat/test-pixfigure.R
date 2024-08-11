library(testthat)
library(pixture)

# setup ------------------------------------------------------------------------

paths <- c("https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/7604425/pexels-photo-7604425.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4666748/pexels-photo-4666748.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4932184/pexels-photo-4932184.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4210900/pexels-photo-4210900.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/3126574/pexels-photo-3126574.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1376201/pexels-photo-1376201.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/7919/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/2437291/pexels-photo-2437291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1679772/pexels-photo-1679772.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1183099/pexels-photo-1183099.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1813513/pexels-photo-1813513.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/931018/pexels-photo-931018.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/267074/pexels-photo-267074.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4622893/pexels-photo-4622893.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")

captions <- c("night", "forest", "shark", "coconut trees", "flowers", "field", "misty", "leaves", "sunset", "mountains", "swamp", "rainstorm", "leaves", "beach", "leopard", "sunflower")

# pixfigure --------------------------------------------------------------------

testthat::context("pixfigure")

test_that("No input", {
  expect_error(pixfigure())
})

test_that("Default", {
  expect_no_error(pixfigure(paths))
  obj <- pixfigure(paths)
  expect_equal(class(obj), c("pixfigure", "htmlwidget"))
  expect_equal(unlist(obj$x$path), paths)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Link", {
  expect_no_error(pixfigure(paths, link = FALSE))
  expect_no_error(pixfigure(paths, link = rep("bla",length(paths))))
  expect_error(pixfigure(paths, link = NULL))
  expect_error(pixfigure(paths, link = NA))
  expect_error(pixfigure(paths, link = "bla"))
  expect_error(pixfigure(paths, link = c(FALSE,FALSE)))
})

test_that("Captions", {
  expect_no_error(pixfigure(paths, caption = captions))
  obj <- pixfigure(paths, caption = captions)
  expect_equal(length(obj$x$caption), length(paths))
  expect_error(pixfigure(paths, caption = captions[-1]))
})

test_that("Captions with NA", {
  captions1 <- captions
  captions1[2] <- NA
  expect_no_error(pixfigure(paths, caption = captions1))
  expect_error(pixfigure(paths, caption = NA))
  expect_no_error(pixfigure(paths, caption = NULL))
})

test_that("Captions with all NA", {
  captions1 <- rep(NA, length(paths))
  expect_no_error(pixfigure(paths, caption = captions1))
})

test_that("Captions as path names", {
  paths1 <- paths
  names(paths1) <- captions
  expect_no_error(pixfigure(paths1))
})

test_that("Captions and captions as path names", {
  paths1 <- paths
  names(paths1) <- captions
  expect_no_error(pixfigure(paths1, caption = captions))
})

test_that("Dimensions", {
  expect_no_error(pixfigure(paths[1], h = "200px"))
  expect_no_error(pixfigure(paths[1], h = "100vh"))
  expect_no_error(pixfigure(paths[1], h = NA))
  expect_no_error(pixfigure(paths[1], h = NULL))
})

test_that("Fit and position", {
  expect_no_error(pixfigure(paths[1], fit = "fill"))
  expect_no_error(pixfigure(paths[1], position = "right"))
})
