
#' @title Create an image gallery.
#' @description Create an image gallery.
#' @param path [Character Vector] Full paths to images.
#' @param caption [Character Vector] Captions for the images equal to length of path.
#' @param caption_valign [Character] Position of the caption. Options are 'none', 'top', 'center', 'bottom' or 'below'.
#' @param caption_halign [Character] Horizontal justification of the caption. Options are 'left', 'center' or 'right'.
#' @param link [Logical/Character Vector] TRUE for lightbox, FALSE to disable the lightbox or a character vector of custom URLs equal to length of path.
#' @param h [Character] Height of the image thumbnails in valid css units.
#' @param w [Character] Width of the image thumbnails in valid css units.
#' @param gap [Character] Gap between thumbnails in valid css units.
#' @param border_radius [Character] Corner radius of image thumbnails in valid css units.
#' @param layout [Character] Gallery layout type. Options are "grid", "fixed", "mosaic", "masonry", "justified", "elastic" or "rhombus". See details.
#' @param shuffle [Logical] A logical indicating whether images are randomly shuffled.
#' @param height [Character] Height of the widget in valid css units.
#' @param width [Character] Width of the widget in valid css units.
#' @param elementId [Character] Parent container ID.
#' @param type Deprecated. Use 'layout'.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @details 
#' grid: Square grid responsive layout. Adjust square size using 'dim'. Width is flexible to fit parent. \cr
#' fixed: Same as grid but strictly fixed dimensions. \cr
#' masonry: Column responsive layout with fixed width. Adjust column width using 'dim'. \cr
#' justified: Similar to masonry but rows have fixed height. Adjust row height using 'dim'. \cr
#' elastic: Single row layout where images are magnified on hover. \cr
#' mosaic: Grid layout with mixed sizes. \cr
#' rhombus: Diamond shaped layout with three columns. Size and number of columns are fixed. Gap can be adjusted.
#' @export
#'
pixgallery <- function(
  path,
  caption = NULL,
  caption_valign = "none",
  caption_halign = "left",
  link = TRUE,
  h = NULL,
  w = NULL,
  gap = "5px",
  border_radius = "0px",
  layout="grid",
  shuffle = FALSE,
  width = "100%",
  height = "100%",
  elementId = NULL,
  type = NULL
  ) {

  # check caption
  if(!is.null(caption)) {
    if(length(caption) != length(path)) stop(paste0("Length of 'caption' (", length(caption), ") is not not equal to the length of 'path' (", length(path), "). If 'caption' is used, it must be the same length as 'path'."))
  } else {
    if(!is.null(names(path))) caption <- names(path)
  }
  names(path) <- NULL

  # check caption position
  caption_valigns <- c("none", "top", "center", "bottom", "below")
  if (!caption_valign %in% caption_valigns) stop(paste0("Parameter 'caption_valign' must be one of '", paste(caption_valigns, collapse = "', '"), "'."))

  # check caption justification
  caption_haligns <- c("left", "center", "right")
  if (!caption_halign %in% caption_haligns) stop(paste0("Parameter 'caption_halign' must be one of '", paste(caption_haligns, collapse = "', '"), "'."))

  # check type
  if(!is.null(type)){
    layout <- type
    warning("Parameter 'type' is deprecated. Please use 'layout'.")
  }

  # check link
  if (is.logical(link)) {
    if (length(link) != 1) {
      stop("Parameter 'link' must be of length 1 if TRUE or FALSE.")
    }
  } else if (is.character(link)) {
    if (length(link) != length(path)) {
      stop(paste0("Length of 'link' (", length(link), ") is not not equal to the length of 'path' (", length(path), "). If 'link' is a character, it must be the same length as 'path'."))
    }
  } else {
    stop("Parameter 'link' must be a logical or a character vector.")
  }

  layouts <- c("grid", "fixed", "mosaic", "elastic", "masonry", "justified", "rhombus")
  if(!layout %in% layouts) stop(paste0("Parameter 'layout' must be one of '",paste(layouts,collapse="', '"),"'."))

  # forward options using x
  x = list(
    path = as.list(path),
    caption = as.list(caption),
    caption_valign = caption_valign,
    caption_halign = caption_halign,
    link = as.list(link),
    h = h,
    w = w,
    gap = gap,
    border_radius = border_radius,
    layout = layout,
    shuffle = shuffle
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
#' @param ... Parameters are passed to \code{\link{runApp}}.
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
