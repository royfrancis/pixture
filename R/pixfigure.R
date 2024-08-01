#' @title Create a figure
#' @description Create a figure
#' @param path A character vector of full paths to images.
#' @param caption A character vector of captions for the images (Optional).
#' @param link A logical or character vector. What happens when you click on the image? TRUE opens up the lightbox, FALSE to disable the lightbox. A character vector of custom URLs equal to length of path.
#' @param h A character denoting height of the image in valid CSS units.
#' @param w A character denoting width of the image in valid CSS units.
#' @param fit String. Passed to \href{https://developer.mozilla.org/en-US/docs/Web/CSS/object-fit}{object-fit} CSS property.
#' @param position String. Passed to \href{https://developer.mozilla.org/en-US/docs/Web/CSS/object-position}{object-position} CSS property.
#' @param height A character denoting height of the widget as a string in valid CSS units.
#' @param width A character denoting width of the widget as a string in valid CSS units.
#' @param elementId A character string denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' 
#' @examples
#' library(pixture)
#' paths <- list.files(path=system.file("extdata/images",package="pixture"),full.names=TRUE)
#' pixfigure(paths)
#' 
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
    width = "100%",
    height = "100%",
    elementId = NULL) {
  if (!is.null(caption)) {
    if (length(caption) != length(path)) stop(paste0("Length of 'caption' (", length(caption), ") is not not equal to the length of 'path' (", length(path), "). If 'caption' is used, it must be the same length as 'path'."))
  } else {
    if (!is.null(names(path))) caption <- names(path)
  }

  names(path) <- NULL

  # check link
  if (is.null(link) || all(is.na(link))) stop("Parameter 'link' must be a logical or a character vector.")
  if (is.logical(link) && (length(link) != 1)) stop("Parameter 'link' must be of length 1. TRUE or FALSE.")
  if (is.character(link)) {
    if (length(link) != length(path)) {
      stop(paste0("Length of 'link' (", length(link), ") is not not equal to the length of 'path' (", length(path), "). If 'link' is a character, it must be the same length as 'path'."))
    }
  }

  # forward options using x
  x <- list(
    path = as.list(path),
    caption = as.list(caption),
    link = as.list(link),
    h = h,
    w = w,
    fit = fit,
    position = position
  )

  # create widget
  createWidget(
    name = "pixfigure",
    x,
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
#' applications and interactive Rmd documents.
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

#' @title Launch pixfigure demo shiny application
#' @description Launches interactive shiny session in the browser.
#' @param ... Parameters are passed to \code{\link{runApp}}.
#' @return This function does not return anything
#' @seealso \code{\link{runApp}}
#' @examples
#' \dontrun{
#' library(pixture)
#' runPixfigure()
#' }
#' @import htmlwidgets
#' @importFrom shiny fluidPage titlePanel sidebarLayout sidebarPanel selectInput checkboxInput uiOutput mainPanel shinyApp
#' @export
#'
runPixfigure <- function(...) {
  appDir <- system.file("app-pixfigure", package = "pixture")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `pixture`.", call. = FALSE)
  }

  shiny::runApp(appDir, ...)
}
