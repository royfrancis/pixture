# pixfigure shiny app

#library(shiny)
#library(pixture)

ui <- fluidPage(
    titlePanel("Pixfigure Demo"),
    sidebarLayout(
        sidebarPanel(width=3,
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
            textInput("caption", "Caption", value="Palm trees")
        }
    })

    output$fig <- pixture::renderPixfigure({
        path <- "https://images.pexels.com/photos/4932184/pexels-photo-4932184.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"

        if(input$caption_check){
          if(!is.null(input$caption)){
            cpt <- input$caption
            pixture::pixfigure(path, caption=cpt, h = input$height, w = input$width, fit = input$fit, position = input$position)
          }
        }else{
            pixture::pixfigure(path, h = input$height, w = input$width, fit = input$fit, position = input$position)
        }
    })
}

shinyApp(ui = ui, server = server)
