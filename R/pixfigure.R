#' Create a simple layout of images
#' @description
#' Create a simple sequential layout of images
#'
#' @param path A character vector of full paths to images.
#' @param caption A character vector of captions for the images (Optional).
#' @param link A logical or character vector. What happens when you click on the image? TRUE opens up the lightbox, FALSE to disable the lightbox. A character vector of custom URLs equal to length of path.
#' @param h A character denoting height of the image in valid CSS units.
#' @param w A character denoting width of the image in valid CSS units.
#' @param fit String. Passed to \href{https://developer.mozilla.org/en-US/docs/Web/CSS/object-fit}{object-fit} CSS property.
#' @param position String. Passed to \href{https://developer.mozilla.org/en-US/docs/Web/CSS/object-position}{object-position} CSS property.
#' @param lightbox A list of options to customize the lightbox. See details.
#' @param height A character denoting height of the widget as a string in valid CSS units.
#' @param width A character denoting width of the widget as a string in valid CSS units.
#' @param elementId A character string denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @details
#' \strong{lightbox options}:\cr
#' The lightbox can be customized by passing a list of options to the \code{lightbox} parameter. Here is an example; \cr
#' \code{
#' pixfigure(
#'  paths,
#'  lightbox = list(
#'    touchNavigation = FALSE,
#'    loop = TRUE
#'  )
#')
#'}\cr
#' The available options for glightbox can be found at \url{https://github.com/biati-digital/glightbox?tab=readme-ov-file#lightbox-options}.
#'
#' @examples
#' library(pixture)
#' paths <- c(
#'   "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg",
#'   "https://images.pexels.com/photos/7604425/pexels-photo-7604425.jpeg",
#'   "https://images.pexels.com/photos/4666748/pexels-photo-4666748.jpeg"
#' )
#' pixfigure(paths)
#'
#' # local example
#' \dontrun{
#' library(pixture)
#' paths <- list.files(path=system.file("extdata/images",package="pixture"),full.names=TRUE)
#' pixfigure(paths)
#' }
#' @export
#'
pixfigure <- function(
  path,
  caption = NULL,
  link = TRUE,
  h = "auto",
  w = "100%",
  fit = "cover",
  position = "center",
  lightbox = list(),
  width = "100%",
  height = "100%",
  elementId = NULL
) {
  if (!is.null(caption)) {
    if (length(caption) != length(path)) {
      stop(paste0(
        "Length of 'caption' (",
        length(caption),
        ") is not not equal to the length of 'path' (",
        length(path),
        "). If 'caption' is used, it must be the same length as 'path'."
      ))
    }
  } else {
    if (!is.null(names(path))) caption <- names(path)
  }

  names(path) <- NULL

  # check link
  if (is.null(link) || all(is.na(link))) {
    stop("Parameter 'link' must be a logical or a character vector.")
  }
  if (is.logical(link) && (length(link) != 1)) {
    stop("Parameter 'link' must be of length 1. TRUE or FALSE.")
  }
  if (is.character(link)) {
    if (length(link) != length(path)) {
      stop(paste0(
        "Length of 'link' (",
        length(link),
        ") is not not equal to the length of 'path' (",
        length(path),
        "). If 'link' is a character, it must be the same length as 'path'."
      ))
    }
  }

  # lightbox options
  # default list if user doesn't provide anything
  lightbox_defaults <- list(
    selector = ".glightbox",
    touchNavigation = TRUE,
    loop = FALSE,
    zoomable = TRUE
  )
  # merge defaults with user-supplied
  lightbox <- modifyList(lightbox_defaults, lightbox)

  # forward options using x
  x <- list(
    path = as.list(path),
    caption = as.list(caption),
    link = as.list(link),
    h = h,
    w = w,
    fit = fit,
    position = position,
    lightbox = lightbox
  )

  # create widget
  createWidget(
    name = "pixfigure",
    x = x,
    width = width,
    height = height,
    package = "pixture",
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = "100%",
      padding = 5,
      browser.fill = TRUE
    )
  )
}

#' Shiny bindings for pixfigure
#'
#' Output and render functions for using pixfigure within Shiny
#' applications and interactive documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a pixfigure
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name pixfigure-shiny
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
#'
pixfigureOutput <- function(outputId, width = "100%", height = "auto") {
  shinyWidgetOutput(outputId, "pixfigure", width, height, package = "pixture")
}

#' @rdname pixfigure-shiny
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
#'
renderPixfigure <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  shinyRenderWidget(expr, pixfigureOutput, env, quoted = TRUE)
}
