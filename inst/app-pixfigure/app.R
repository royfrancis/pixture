# pixfigure shiny app

path <- "https://images.pexels.com/photos/4932184/pexels-photo-4932184.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940;https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940;https://images.pexels.com/photos/7604425/pexels-photo-7604425.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
captions <- "Palm trees;Night sky;Woodland"

ui <- fluidPage(
  titlePanel("Pixfigure"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      textAreaInput("path", "Image paths", value = path, height = "200px"),
      textInput("sep", "Separator", value = ";"),
      checkboxInput("caption_check", "Use captions", value = FALSE),
      uiOutput("caption_ui"),
      checkboxInput("link", "Use lightbox", value = TRUE),
      textInput("h", label = "Height", value = "auto"),
      textInput("w", label = "Width", value = "100%"),
      textInput("fit", label = "Object fit", value = "cover"),
      textInput("position", label = "Object position", value = "center"),
      HTML("Image from <a href='https://www.pexels.com/'>Pexels.</a>")
    ),
    mainPanel(
      width = 9,
      pixture::pixfigureOutput("fig")
    )
  )
)

server <- function(input, output) {
  output$caption_ui <- renderUI({
    if (input$caption_check) {
      textInput("caption", "Caption", value = captions)
    }
  })

  output$fig <- pixture::renderPixfigure({
    if (!is.null(input$path)) {
      path <- unlist(strsplit(input$path, input$sep))
    }

    if (input$caption_check) {
      if (!is.null(input$caption)) {
        cpt <- unlist(strsplit(input$caption, ";"))
        if (length(cpt) != length(path)) {
          stop("Number of captions do not match number of images.")
        }
        pixture::pixfigure(
          path,
          caption = cpt,
          link = input$link,
          h = input$h,
          w = input$w,
          fit = input$fit,
          position = input$position
        )
      }
    } else {
      pixture::pixfigure(
        path,
        link = input$link,
        h = input$h,
        w = input$w,
        fit = input$fit,
        position = input$position
      )
    }
  })
}

shinyApp(ui = ui, server = server)
