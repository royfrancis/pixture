#' Interactive shiny app
#' @description
#' Launches interactive shiny demo app
#' 
#' @param app A character string denoting the app. Options are "pixfigure", "pixgallery", "pixgallery-simple"
#' @param ... Parameters are passed to \code{runApp()}.
#' @return This function does not return anything
#' @examples
#' \dontrun{
#' library(pixture)
#' launchApp()
#' }
#' @import htmlwidgets
#' @importFrom shiny runApp
#' @export
#'
launchApp <- function(app = "pixgallery", ...) {
  app_dir <- system.file(paste0("app-",app), package = "pixture")
  if(!dir.exists(app_dir)){
    stop("Could not find directory. Is the app directory correct?")
  }
  runApp(app_dir, ...)
}
