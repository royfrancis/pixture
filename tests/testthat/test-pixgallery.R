library(testthat)
library(pixture)

# setup ------------------------------------------------------------------------

paths <- c(
  "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
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
  "https://images.pexels.com/photos/4622893/pexels-photo-4622893.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
)

captions <- c("night", "forest", "shark", "coconut trees", "flowers", "field", "misty", "leaves", "sunset", "mountains", "swamp", "rainstorm", "leaves", "beach", "leopard", "sunflower")

# pixgallery -------------------------------------------------------------------

testthat::context("pixgallery")

test_that("No input", {
  expect_error(pixgallery())
})

test_that("Default",{
  expect_no_error(pixgallery(paths))
  obj <- pixgallery(paths)
  expect_equal(class(obj), c("pixgallery", "htmlwidget"))
  expect_equal(unlist(obj$x$path), paths)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Captions",{
  expect_no_error(pixgallery(paths, caption = captions))
  obj <- pixgallery(paths, caption = captions)
  expect_equal(length(obj$x$caption), length(paths))
  expect_error(pixgallery(paths, caption = captions[-1]))
})

test_that("Captions with NA", {
  captions1 <- captions
  captions1[2] <- NA
  expect_no_error(pixgallery(paths, caption = captions1))
  expect_error(pixgallery(paths, caption = NA))
  expect_no_error(pixgallery(paths, caption = NULL))
})

test_that("Captions with all NA", {
  captions1 <- rep(NA,length(paths))
  expect_no_error(pixgallery(paths, caption = captions1))
})

test_that("Captions as path names", {
  paths1 <- paths
  names(paths1) <- captions
  expect_no_error(pixgallery(paths1))
})

test_that("Captions and captions as path names", {
  paths1 <- paths
  names(paths1) <- captions
  expect_no_error(pixgallery(paths1, caption = captions))
})

test_that("Captions caption_valign", {
  expect_no_error(pixgallery(paths, caption = captions, caption_valign = "top"))
  expect_no_error(pixgallery(paths, caption = captions, caption_valign = "center"))
  expect_no_error(pixgallery(paths, caption = captions, caption_valign = "bottom"))
  expect_no_error(pixgallery(paths, caption = captions, caption_valign = "below"))
  expect_error(pixgallery(paths, caption = captions, caption_valign = "bla"))
  expect_error(pixgallery(paths, caption = captions, caption_valign = NA))
  expect_error(pixgallery(paths, caption = captions, caption_valign = NULL))
})

test_that("Captions caption_halign", {
  expect_no_error(pixgallery(paths, caption = captions, caption_halign = "center"))
  expect_no_error(pixgallery(paths, caption = captions, caption_halign = "right"))
  expect_error(pixgallery(paths, caption = captions, caption_halign = "bla"))
  expect_error(pixgallery(paths, caption = captions, caption_halign = NA))
  expect_error(pixgallery(paths, caption = captions, caption_halign = NULL))
})

test_that("Captions and link", {
  expect_no_error(pixgallery(paths, caption = captions, link = FALSE))
  expect_no_error(pixgallery(paths, caption = captions, link = rep("bla",length(captions))))
  expect_error(pixgallery(paths, caption = captions, link = "bla"))
  expect_error(pixgallery(paths, caption = captions, link = NA))
  expect_error(pixgallery(paths, caption = captions, link = NULL))
  expect_error(pixgallery(paths, caption = captions, link = c(T,F)))
})

test_that("Layouts default", {
  expect_no_error(pixgallery(paths, layout = "fixed"))
  expect_no_error(pixgallery(paths, layout = "mosaic"))
  expect_no_error(pixgallery(paths, layout = "masonry"))
  expect_no_error(pixgallery(paths, layout = "justified"))
  expect_no_error(pixgallery(paths, layout = "elastic"))
  expect_no_error(pixgallery(paths, layout = "rhombus"))
  expect_error(pixgallery(paths, layout = NA))
  expect_error(pixgallery(paths, layout = NULL))
})

test_that("Layouts default with caption", {
  expect_no_error(pixgallery(paths, caption = captions, layout = "fixed"))
  expect_no_error(pixgallery(paths, caption = captions, layout = "mosaic"))
  expect_no_error(pixgallery(paths, caption = captions, layout = "masonry"))
  expect_no_error(pixgallery(paths, caption = captions, layout = "justified"))
  expect_no_error(pixgallery(paths, caption = captions, layout = "elastic"))
  expect_no_error(pixgallery(paths, caption = captions, layout = "rhombus"))
})

test_that("Dimensions", {
  expect_no_error(pixgallery(paths, layout = "grid", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, layout = "fixed", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, layout = "mosaic", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, layout = "masonry", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, layout = "justified", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, layout = "elastic", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, layout = "rhombus", h = "50px", w = "50px"))
  expect_no_error(pixgallery(paths, h = NA, w = NA))
  expect_no_error(pixgallery(paths, h = NULL, w = NULL))
})

test_that("Shuffle default", {
  expect_no_error(pixgallery(paths,shuffle=TRUE))
  obj <- pixgallery(paths,shuffle=TRUE)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Shuffle with caption", {
  expect_no_error(pixgallery(paths, caption = captions, shuffle = TRUE))
  obj <- pixgallery(paths, caption = captions, shuffle = TRUE)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Shuffle incorrect input", {
  expect_error(pixgallery(paths, shuffle = NA))
  expect_error(pixgallery(paths, shuffle = NULL))
})

# check that shuffled order of images match captions (to do)

test_that("Deprecated", {
  expect_warning(pixgallery(paths, type="grid"))
  expect_warning(pixgallery(paths, dim = "50px"))
})