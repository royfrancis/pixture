
#' @title Create an image gallery.
#' @description Create an image gallery.
#' @param path A character vector of paths to images.
#' @param caption A character vector of captions for the images (Optional).
#' @param preset A character denoting predefined layout style. Defaults to "grid".
#' @param options A named list of freewall options, See \url{http://kombai.github.io/freewall/#options}.
#' @param height A numeric in pixel denoting height of the widget.
#' @param width A numeric denoting width of the widget.
#' @param elementId A character denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @export
#'
pixture <- function(path, caption = NULL, preset = "grid", options = list(),
                    width = "100%", height = NULL, elementId = NULL) {

  if(!is.null(caption)) {
    if(length(caption) != length(path)) stop("Length of caption must be same as path.")
  } else {
    caption <- rep(NULL,length(path))
  }

  if(length(options)!=0) {
    if(any(is.null(names(options)))) stop("Argument 'options' must be a named list.")
    if(any(is.na(names(options)))) stop("Argument 'options' must be a named list.")
  }

  if(is.null(options$draggable)) options$draggable <- FALSE
  if(is.null(options$animate)) options$animate <- TRUE
  if(is.null(options$cellW)) options$cellW <- 200
  if(is.null(options$cellH)) options$cellH <- 200
  if(is.null(options$delay)) options$delay <- 30
  if(is.null(options$gutterX)) options$gutterX <- 5
  if(is.null(options$gutterY)) options$gutterY <- 5
  options$selector <- '.fw-cell'
  if(is.null(options$cacheSize)) options$cacheSize <- TRUE
  if(is.null(options$keepOrder)) options$keepOrder <- TRUE
  if(is.null(options$rightToLeft)) options$rightToLeft <- FALSE
  if(is.null(options$bottomToTop)) options$bottomToTop <- FALSE

  # forward options using x
  x = list(
    path = path,
    caption = caption,
    preset = preset,
    options = options
  )

  # create widget
  createWidget(
    name = 'pixture',
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

#' Shiny bindings for pixture
#'
#' Output and render functions for using pixture within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a pixture
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name pixture-shiny
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
#'
pixtureOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'pixture', width, height, package = 'pixture')
}

#' @rdname pixture-shiny
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
#'
renderPixture <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, pixtureOutput, env, quoted = TRUE)
}

#' @title Launch pixture demo shiny application
#' @description Launches interactive shiny session in the browser.
#' @param display.mode Display mode. See \code{\link{runApp}}.
#' @param launch.browser Logical indicating if the app is to be launched in the system browser.
#' @param ... Further arguments are passed to \code{\link{runApp}}.
#' @return This function does not return anything
#' @seealso \code{\link{runApp}}
#' @examples
#' \dontrun{
#' library(pixture)
#' runPixture()
#' }
#' @import htmlwidgets
#' @importFrom shiny fluidPage titlePanel sidebarLayout sidebarPanel selectInput checkboxInput uiOutput mainPanel shinyApp
#' @export
#'
runPixture <- function(display.mode="normal",launch.browser=TRUE,...) {
  appDir <- system.file("app", package="pixture")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `pixture`.", call. = FALSE)
  }

  shiny::runApp(appDir,display.mode=display.mode,launch.browser=launch.browser,...)
}
