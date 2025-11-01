#' Create a carousel
#'
#' Generates an image carousel
#' 
#' @param path A character vector of full paths to images.
#' @param slides_to_show Number of images to be displayed.
#' @param slides_to_scroll Number of images to scroll.
#' @param draggable Logical indicating if the carousal is draggable.
#' @param show_buttons Logical indicating if buttons are displayed.
#' @param show_dots Logical indicating if dots are displayed.
#' @param scroll_lock Logical indicating if carousal scrolls to nearest image after interaction.
#' @param rewind Logical indicating if carousal scrolls to beginning/end at endpoints.
#' @param h A character denoting height of the image thumbnails in valid CSS units.
#' @param height A character denoting height of the widget in valid CSS units.
#' @param width A character denoting width of the widget in valid CSS units.
#' @param elementId A character string denoting parent container ID.
#' @import htmlwidgets
#'
#' @export
#' 
pixcarousel <- function(
  path,
  slides_to_show = 1,
  slides_to_scroll = 1,
  draggable = TRUE,
  show_buttons = TRUE,
  show_dots = TRUE,
  scroll_lock = TRUE,
  rewind = FALSE,
  h = "400px",
  width = NULL, 
  height = NULL, 
  elementId = NULL
  ) {

  # forward options using x
  x = list(
    path = as.list(path),
    slides_to_show = slides_to_show,
    slides_to_scroll = slides_to_scroll,
    draggable = draggable,
    show_buttons = show_buttons,
    show_dots = show_dots,
    scroll_lock = scroll_lock,
    rewind = rewind,
    h = h
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'pixcarousel',
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

#' Shiny bindings for pixcarousel
#'
#' Output and render functions for using pixcarousel within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a pixcarousel
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name pixcarousel-shiny
#'
#' @export
pixcarouselOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'pixcarousel', width, height, package = 'pixture')
}

#' @rdname pixcarousel-shiny
#' @export
renderPixcarousel <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, pixcarouselOutput, env, quoted = TRUE)
}
