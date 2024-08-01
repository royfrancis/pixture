#' @title Interactive Pixfigure Demo
#' @description Launches interactive shiny demo session in the browser
#' @param display.mode Display mode. See \code{\link{runApp}}.
#' @param launch.browser Logical indicating if the app is to be launched in the system browser.
#' @param ... Further arguments are passed to \code{\link{runApp}}.
#' @return This function does not return anything
#' @seealso \code{\link{runApp}}
#' @examples
#' \dontrun{
#' library(pixture)
#' runPixfigure()
#' }
#' @export
#'
runPixfigure <- function(display.mode = "normal", launch.browser = TRUE, ...) {
  appDir <- system.file("app-pixfigure", package = "pixture")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `pixture`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = display.mode, launch.browser = launch.browser, ...)
}

#' @title Interactive Pixgallery Demo
#' @description Launches interactive shiny demo session in the browser
#' @param display.mode Display mode. See \code{\link{runApp}}.
#' @param launch.browser Logical indicating if the app is to be launched in the system browser.
#' @param ... Further arguments are passed to \code{\link{runApp}}.
#' @return This function does not return anything
#' @seealso \code{\link{runApp}}
#' @examples
#' \dontrun{
#' library(pixture)
#' runPixgallery()
#' }
#' @export
#'
runPixgallery <- function(display.mode = "normal", launch.browser = TRUE, ...) {
  appDir <- system.file("app-pixgallery", package = "pixture")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `pixture`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = display.mode, launch.browser = launch.browser, ...)
}
