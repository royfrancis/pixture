#' Create an image gallery
#'
#' @description
#' Create an image gallery
#' @param path A character vector of full paths to images.
#' @param caption A character vector of captions for the images (Optional). It must be equal to the length of path.
#' @param caption_valign A character denoting position of the caption. Options are 'none', 'top', 'center', 'bottom' or 'below'.
#' @param caption_halign A character denoting horizontal justification of the caption. Options are 'left', 'center' or 'right'.
#' @param link A logical or character vector. What happens when you click on the thumbnail? TRUE opens up the lightbox, FALSE to disable the lightbox. A character vector of custom URLs equal to length of path.
#' @param h A character denoting height of the image thumbnails in valid CSS units.
#' @param w A character denoting width of the image thumbnails in valid CSS units.
#' @param gap A character denoting spacing between thumbnails in valid CSS units.
#' @param border_radius A character denoting corner radius of image thumbnails in valid CSS units.
#' @param layout A character denoting gallery layout type. Options are "grid", "fixed", "mosaic", "masonry", "justified", "scroll", "elastic" or "rhombus". See details.
#' @param shuffle A logical indicating whether images are randomly shuffled.
#' @param height A character denoting height of the widget in valid CSS units.
#' @param width A character denoting width of the widget in valid CSS units.
#' @param elementId A character string denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @details
#' \strong{grid}: Grid responsive layout. Width is fluid to fit parent. When using \code{caption_valign} options 'top', 'bottom' or 'center', height cannot be adjusted. \cr
#' \cr
#' \strong{fixed}: Same as grid but with strictly fixed dimensions. Defaults to square image. When using \code{caption_valign} options 'top', 'bottom' or 'center', note that long captions may overflow. Manually set height in this case. \cr
#' \cr
#' \strong{mosaic}: Grid layout with mixed sizes. \cr
#' \cr
#' \strong{masonry}: Column layout where images flow vertically. Image height cannot be set. \cr
#' \cr
#' \strong{justified}: Similar to masonry but images flow horizontally. Image width cannot be set. When using \code{caption_valign} options 'top', 'bottom' or 'center', note that long captions are clipped. Option 'below' may cause images to be stretched if captions are too long. \cr
#' \cr
#' \strong{elastic}: Single row layout where images are magnified on hover. Image width cannot be set. Captions cannot be displayed on thumbnails. \cr
#' \cr
#' \strong{scroll}: Single row layout with horizontal scrolling. Images go offscreen. Thumbnail height and width can be set. \cr
#' \strong{rhombus}: Diamond shaped layout with three columns. Image size and number of columns are fixed. Completely non-responsive without breakpoints. Captions cannot be displayed on thumbnails. \cr
#'
#' @examples
#' library(pixture)
#' paths <- c(
#'  "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg",
#'  "https://images.pexels.com/photos/7604425/pexels-photo-7604425.jpeg",
#'  "https://images.pexels.com/photos/4666748/pexels-photo-4666748.jpeg",
#'  "https://images.pexels.com/photos/4932184/pexels-photo-4932184.jpeg",
#'  "https://images.pexels.com/photos/4210900/pexels-photo-4210900.jpeg",
#'  "https://images.pexels.com/photos/3126574/pexels-photo-3126574.jpeg",
#'  "https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg",
#'  "https://images.pexels.com/photos/1376201/pexels-photo-1376201.jpeg"
#' )
#' pixgallery(paths)
#'
#' # local example
#' \dontrun{
#' library(pixture)
#' paths <- list.files(path=system.file("extdata/images",package="pixture"),full.names=TRUE)
#' pixgallery(paths)
#' }
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
  layout = "grid",
  shuffle = FALSE,
  width = "100%",
  height = "100%",
  elementId = NULL
) {
  # check caption
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

  # check caption position
  caption_valigns <- c("none", "top", "center", "bottom", "below")
  if (is.null(caption_valign) || !caption_valign %in% caption_valigns) {
    stop(paste0(
      "Parameter 'caption_valign' must be one of '",
      paste(caption_valigns, collapse = "', '"),
      "'."
    ))
  }

  # check caption justification
  caption_haligns <- c("left", "center", "right")
  if (is.null(caption_halign) || (!caption_halign %in% caption_haligns)) {
    stop(paste0(
      "Parameter 'caption_halign' must be one of '",
      paste(caption_haligns, collapse = "', '"),
      "'."
    ))
  }

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

  # check layout
  layouts <- c(
    "grid",
    "fixed",
    "mosaic",
    "elastic",
    "masonry",
    "scroll",
    "justified",
    "rhombus"
  )
  if (is.null(layout) || (!layout %in% layouts)) {
    stop(paste0(
      "Parameter 'layout' must be one of '",
      paste(layouts, collapse = "', '"),
      "'."
    ))
  }

  # check shuffle
  if (is.null(shuffle) || is.na(shuffle) || (!is.logical(shuffle))) {
    stop("Parameter 'shuffle' must be a logical. TRUE or FALSE.")
  }

  # forward options using x
  x <- list(
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
    name = "pixgallery",
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

#' Shiny bindings for pixgallery
#'
#' Output and render functions for using pixgallery within Shiny
#' applications and interactive documents.
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
pixgalleryOutput <- function(outputId, width = "100%", height = "100%") {
  shinyWidgetOutput(outputId, "pixgallery", width, height, package = "pixture")
}

#' @rdname pixgallery-shiny
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
#'
renderPixgallery <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  shinyRenderWidget(expr, pixgalleryOutput, env, quoted = TRUE)
}
