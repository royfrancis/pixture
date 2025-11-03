#' Create a carousel
#'
#' @description
#' Creates an image carousel
#' @param path A character vector of full paths to images.
#' @param caption A character vector of captions for the images (Optional). It must be equal to the length of path.
#' @param caption_valign A character denoting position of the caption. Options are 'none', 'top', 'center' or 'bottom'.
#' @param caption_halign A character denoting horizontal justification of the caption. Options are 'left', 'center' or 'right'.
#' @param link A logical or character vector. What happens when you click on the thumbnail? TRUE opens up the lightbox, FALSE to disable the lightbox. A character vector of custom URLs equal to length of path.
#' @param gap A character denoting spacing between thumbnails in valid CSS units.
#' @param border_radius A character denoting corner radius of the carousel in valid CSS units.
#' @param shuffle A logical indicating whether images are randomly shuffled.
#' @param carousel A list of options to customize the carousel. See details.
#' @param lightbox A list of options to customize the lightbox. See details.
#' @param h A character denoting height of the image thumbnails in valid CSS units.
#' @param height A character denoting height of the widget in valid CSS units.
#' @param width A character denoting width of the widget in valid CSS units.
#' @param elementId A character string denoting parent container ID.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @details
#' \strong{carousel options}:\cr
#' The carousel can be customized by passing a list of options to the \code{carousel} parameter. Here is an example; \cr
#' \code{
#' pixcarousel(
#'  paths,
#'  carousel = list(
#'   slidesToShow = 3,
#'   slidesToScroll = 2
#'  )
#')
#'}\cr
#' The available options for carousel can be found at \url{https://github.com/NickPiscitelli/Glider.js} or \url{https://nickpiscitelli.github.io/Glider.js/}.
#' \cr
#' \strong{lightbox options}:\cr
#' The lightbox can be customized by passing a list of options to the \code{lightbox} parameter. Here is an example; \cr
#' \code{
#' pixcarousel(
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
#' pixcarousel(paths)
#' }
#' @export
#'
pixcarousel <- function(
  path,
  caption = NULL,
  caption_valign = "none",
  caption_halign = "left",
  link = TRUE,
  gap = "0px",
  border_radius = "0px",
  shuffle = FALSE,
  carousel = list(),
  lightbox = list(),
  h = "400px",
  width = NULL,
  height = NULL,
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
  caption_valigns <- c("none", "top", "center", "bottom")
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

  # check if shuffle is logical, length 1 and not NA or NULL
  if (
    is.null(shuffle) ||
      is.na(shuffle) ||
      !is.logical(shuffle) ||
      (length(shuffle) != 1)
  ) {
    stop("Parameter 'shuffle' must be a logical of length 1 (TRUE or FALSE).")
  }

  # carousel options
  # default list if user doesn't provide anything
  carousel_defaults <- list(
    draggable = TRUE,
    scrollLock = TRUE
  )

  # merge defaults with user-supplied
  carousel <- modifyList(carousel_defaults, carousel)

  # lightbox options
  # default list if user doesn't provide anything
  lightbox_defaults <- list(
    selector = ".glightbox"
  )
  # merge defaults with user-supplied
  lightbox <- modifyList(lightbox_defaults, lightbox)

  # forward options using x
  x = list(
    path = as.list(path),
    caption = as.list(caption),
    caption_valign = caption_valign,
    caption_halign = caption_halign,
    link = as.list(link),
    gap = gap,
    border_radius = border_radius,
    shuffle = shuffle,
    carousel = carousel,
    lightbox = lightbox,
    h = h
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'pixcarousel',
    x = x,
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
pixcarouselOutput <- function(outputId, width = '100%', height = '400px') {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    'pixcarousel',
    width,
    height,
    package = 'pixture'
  )
}

#' @rdname pixcarousel-shiny
#' @export
renderPixcarousel <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, pixcarouselOutput, env, quoted = TRUE)
}
