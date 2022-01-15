
#' @title Create an image gallery.
#' @description Create an image gallery.
#' @param path A character vector of paths to images.
#' @param caption A character vector of captions for the images (Optional).
#' @param dim Image dimension in valid css units.
#' @param gap Gap between cells as a string in valid css units.
#' @param type Gallery type. "box" or "grid" for now.
#' @param height Height of the widget as a string.
#' @param width Width of the widget as a string.
#' @param elementId A character denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @export
#'
pixgallery <- function(path, caption = NULL, dim = "200px", gap = "6px",
                        type="grid", width = "100%", height = "100%", elementId = NULL) {

  if(!is.null(caption)) {
    if(length(caption) != length(path)) stop(paste("Length of 'caption' (", length(caption), ") is not not equal to the length of 'path' (", length(path), "). If 'caption' is used, it must be the same length as 'path'."))
  } else {
    if(!is.null(names(path))){
      caption <- names(path)
    }else{
      caption <- rep(NULL, length(path))
    }
  }

  names(path) <- NULL

  types <- c("box","grid")
  if(!type %in% types) stop(paste0("Argument type must be one of ",paste(types,collapse=","),"."))

  # forward options using x
  x = list(
    path = as.list(path),
    caption = caption,
    dim = dim,
    gap = gap,
    type = type
  )

  # create widget
  createWidget(
    name = 'pixgallery',
    x,
    width = width,
    height = height,
    package = 'pixture',
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = "100%",
      padding = 5,
      browser.fill = TRUE
    )
  )
}

#' Shiny bindings for pixgallery
#'
#' Output and render functions for using pixgallery within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a pixgallery
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name pixgallery-shiny
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
#'
pixgalleryOutput <- function(outputId, width = '100%', height = '100%'){
  shinyWidgetOutput(outputId, 'pixgallery', width, height, package = 'pixture')
}

#' @rdname pixgallery-shiny
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
#'
renderPixgallery <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, pixgalleryOutput, env, quoted = TRUE)
}

#' @title Launch pixgallery demo shiny application
#' @description Launches interactive shiny session in the browser.
#' @param ... Arguments are passed to \code{\link{runApp}}.
#' @return This function does not return anything
#' @seealso \code{\link{runApp}}
#' @examples
#' \dontrun{
#' library(pixture)
#' runPixgallery()
#' }
#' @import htmlwidgets
#' @importFrom shiny fluidPage titlePanel sidebarLayout sidebarPanel selectInput checkboxInput uiOutput mainPanel shinyApp
#' @export
#'
runPixgallery <- function(...) {
  appDir <- system.file("app", package = "pixture")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `pixture`.", call. = FALSE)
  }

  shiny::runApp(appDir, ...)
}
