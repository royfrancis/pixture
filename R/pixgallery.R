
#' @title Create an image gallery.
#' @description Create an image gallery.
#' @param path A character vector of full paths to images.
#' @param caption A character vector of captions for the images equal to length of path.
#' @param dim Image gallery thumbnail dimension as a string in valid css units.
#' @param gap Gap between thumbnails as a string in valid css units.
#' @param border_radius Corner radius of thumbnails as a string in valid css units.
#' @param shuffle A logical indicating whether images are randomly shuffled.
#' @param layout A character indicating gallery layout type. "grid", "gridfixed", "masonry", "justified", "elastic" or "rhombus". See details.
#' @param height Height of the widget as a string in valid css units.
#' @param width Width of the widget as a string in valid css units.
#' @param elementId A character denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @details 
#' grid: Square grid responsive layout. Adjust square size using 'dim'. Width is flexible to fit parent.\n
#' gridfixed: Same as grid but strictly fixed dimensions.\n
#' masonry: Column responsive layout with fixed width. Adjust column width using 'dim'.\n
#' justified: Similar to masonry but rows have fixed height. Adjust row height using 'dim'.\n
#' elastic: Single row layout where images are magnified on hover.\n
#' rhombus: Diamond shaped layout with three columns. Size and number of columns are fixed. Gap can be adjusted.
#' @export
#'
pixgallery <- function(
  path, 
  caption = NULL, 
  dim = "200px", 
  gap = "5px", 
  border_radius = "0px", 
  shuffle = FALSE,
  layout="grid", 
  width = "100%", 
  height = "100%", 
  elementId = NULL
  ) {

  # check caption
  if(!is.null(caption)) {
    if(length(caption) != length(path)) stop(paste0("Length of 'caption' (", length(caption), ") is not not equal to the length of 'path' (", length(path), "). If 'caption' is used, it must be the same length as 'path'."))
  } else {
    if(!is.null(names(path))) caption <- names(path)
  }

  names(path) <- NULL

  layouts <- c("grid", "gridfixed", "rhombus", "elastic", "masonry", "justified")
  if(!layout %in% layouts) stop(paste0("Argument 'layout' must be one of '",paste(layouts,collapse="', '"),"'."))

  # forward options using x
  x = list(
    path = as.list(path),
    caption = as.list(caption),
    link = as.list(link),
    dim = dim,
    gap = gap,
    border_radius = border_radius,
    shuffle = shuffle,
    layout = layout
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
  appDir <- system.file("app-pixgallery", package = "pixture")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `pixture`.", call. = FALSE)
  }

  shiny::runApp(appDir, ...)
}
