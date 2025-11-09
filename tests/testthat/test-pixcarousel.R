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

captions <- c(
  "night",
  "forest",
  "shark",
  "coconut trees",
  "flowers",
  "field",
  "misty",
  "leaves",
  "sunset",
  "mountains",
  "swamp",
  "rainstorm",
  "leaves",
  "beach",
  "leopard",
  "sunflower"
)

# pixcarousel -------------------------------------------------------------------

test_that("No input", {
  expect_error(pixcarousel())
})

test_that("Default", {
  expect_no_error(pixcarousel(paths))
  obj <- pixcarousel(paths)
  expect_equal(class(obj), c("pixcarousel", "htmlwidget"))
  expect_equal(unlist(obj$x$path), paths)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Captions", {
  expect_no_error(pixcarousel(paths, caption = captions))
  obj <- pixcarousel(paths, caption = captions)
  expect_equal(length(obj$x$caption), length(paths))
  expect_error(pixcarousel(paths, caption = captions[-1]))
})

test_that("Captions with NA", {
  captions1 <- captions
  captions1[2] <- NA
  expect_no_error(pixcarousel(paths, caption = captions1))
  expect_error(pixcarousel(paths, caption = NA))
  expect_no_error(pixcarousel(paths, caption = NULL))
})

test_that("Captions with all NA", {
  captions1 <- rep(NA, length(paths))
  expect_no_error(pixcarousel(paths, caption = captions1))
})

test_that("Captions as path names", {
  paths1 <- paths
  names(paths1) <- captions
  expect_no_error(pixcarousel(paths1))
})

test_that("Captions and captions as path names", {
  paths1 <- paths
  names(paths1) <- captions
  expect_no_error(pixcarousel(paths1, caption = captions))
})

test_that("Captions caption_valign", {
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_valign = "top"
  ))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_valign = "center"
  ))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_valign = "bottom"
  ))
  expect_error(pixcarousel(paths, caption = captions, caption_valign = "bla"))
  expect_error(pixcarousel(paths, caption = captions, caption_valign = NA))
  expect_error(pixcarousel(paths, caption = captions, caption_valign = NULL))
})

test_that("Captions caption_halign", {
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_halign = "left"
  ))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_halign = "center"
  ))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_halign = "right"
  ))
  expect_error(pixcarousel(paths, caption = captions, caption_halign = "bla"))
  expect_error(pixcarousel(paths, caption = captions, caption_halign = NA))
  expect_error(pixcarousel(paths, caption = captions, caption_halign = NULL))
})

test_that("Captions and link", {
  expect_no_error(pixcarousel(paths, caption = captions, link = FALSE))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    link = rep("bla", length(captions))
  ))
  expect_error(pixcarousel(paths, caption = captions, link = "bla"))
  expect_error(pixcarousel(paths, caption = captions, link = NA))
  expect_error(pixcarousel(paths, caption = captions, link = NULL))
  expect_error(pixcarousel(paths, caption = captions, link = c(T, F)))
})

test_that("Captions and caption_lightbox", {
  expect_no_error(pixcarousel(paths, caption = captions, caption_lightbox = FALSE))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_valign = "bottom",
    caption_lightbox = FALSE
  ))
  expect_no_error(pixcarousel(
    paths,
    caption_lightbox = rep("bla", length(captions))
  ))
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    caption_lightbox = rep("bla", length(captions))
  ))
  expect_error(pixcarousel(paths, caption = captions, caption_lightbox = "bla"))
  expect_error(pixcarousel(paths, caption = captions, caption_lightbox = NA))
  expect_error(pixcarousel(paths, caption = captions, caption_lightbox = NULL))
  expect_error(pixcarousel(paths, caption = captions, caption_lightbox = c(T, F)))
})

test_that("fit and position", {
  expect_no_error(pixcarousel(paths, fit = "contain"))
  expect_no_error(pixcarousel(paths, position = "left"))
  expect_no_error(pixcarousel(paths, caption = captions, fit = "contain"))
  expect_no_error(pixcarousel(paths, caption = captions, position = "right"))
  expect_no_error(pixcarousel(paths, caption = captions, fit = "fill", position = "top"))
  expect_no_error(pixcarousel(paths, caption = captions, fit = "none", position = "bottom"))
})

test_that("Slides", {
  expect_no_error(pixcarousel(paths, carousel = list(slidesToShow = 5, slidesToScroll = 2)))
})

test_that("Other", {
  expect_no_error(pixcarousel(
    paths,
    carousel = list(
      draggable = TRUE,
      scrollLock = FALSE,
      rewind = TRUE
    )
  ))
})

test_that("Dimensions", {
  expect_no_error(pixcarousel(paths, h = "20px"))
  expect_no_error(pixcarousel(paths, h = NA))
  expect_no_error(pixcarousel(paths, h = NULL))
})

test_that("Shuffle default", {
  expect_no_error(pixcarousel(paths, shuffle = TRUE))
  obj <- pixcarousel(paths, shuffle = TRUE)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Shuffle with caption", {
  expect_no_error(pixcarousel(paths, caption = captions, shuffle = TRUE))
  obj <- pixcarousel(paths, caption = captions, shuffle = TRUE)
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Shuffle incorrect input", {
  expect_error(pixcarousel(paths, shuffle = NA))
  expect_error(pixcarousel(paths, shuffle = NULL))
})

test_that("Shuffle with link and caption_lightbox", {
  expect_no_error(pixcarousel(
    paths,
    caption = captions,
    link = rep("bla", length(captions)),
    caption_lightbox = rep("bli", length(captions)),
    shuffle = TRUE
  ))
  obj <- pixcarousel(
    paths,
    caption = captions,
    link = rep("bla", length(captions)),
    caption_lightbox = rep("bli", length(captions)),
    shuffle = TRUE
  )
  expect_equal(length(obj$x$path), length(paths))
})

test_that("Shuffle check order of path, caption, link and caption_lightbox", {
  obj <- pixcarousel(
    paths,
    caption = captions,
    link = paste0("link_", seq_along(paths)),
    caption_lightbox = paste0("lightbox_", seq_along(paths)),
    shuffle = TRUE
  )
  expect_equal(length(obj$x$path), length(paths))
  for (i in seq_along(paths)) {
    path_i <- obj$x$path[[i]]
    index <- which(paths == path_i)
    expect_equal(obj$x$caption[[i]], captions[index])
    expect_equal(obj$x$link[[i]], paste0("link_", index))
    expect_equal(obj$x$caption_lightbox[[i]], paste0("lightbox_", index))
  }
})
