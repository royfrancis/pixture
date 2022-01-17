# pixfigure shiny app

#library(shiny)
#library(pixture)

path <- "https://images.pexels.com/photos/4932184/pexels-photo-4932184.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940;https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940;https://images.pexels.com/photos/7604425/pexels-photo-7604425.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
captions <- "Palm trees;Night sky;Woodland"

ui <- fluidPage(
    titlePanel("Pixfigure Demo"),
    sidebarLayout(
        sidebarPanel(width=3,
            textAreaInput("path", "Image URLs", value=path, height="200px"),
            checkboxInput("caption_check", "Use captions", value=FALSE),
            uiOutput("caption_ui"),
            textInput("height", label = "Height", value="auto"),
            textInput("width", label = "Width", value="100%"),
            textInput("fit", label = "Object fit", value="cover"),
            textInput("position", label = "Object position", value="center"),
            HTML("Image from <a href='https://www.pexels.com/'>Pexels.</a>")
        ),
        mainPanel(width=9,
            pixture::pixfigureOutput("fig")
        )
    )
)

server <- function(input, output) {
    output$caption_ui <- renderUI({
        if(input$caption_check) {
            textInput("caption", "Caption", value=captions)
        }
    })

    output$fig <- pixture::renderPixfigure({
      
      if(!is.null(input$path)) path <- unlist(strsplit(input$path, ";"))

      if(input$caption_check){
        if(!is.null(input$caption)){
          cpt <- unlist(strsplit(input$caption, ";"))
          if(length(cpt)!=length(path)) stop("Number of captions do not match number of images.")
          pixture::pixfigure(path, caption=cpt, h = input$height, w = input$width, fit = input$fit, position = input$position)
        }
      }else{
          pixture::pixfigure(path, h = input$height, w = input$width, fit = input$fit, position = input$position)
      }
    })
}

shinyApp(ui = ui, server = server)
