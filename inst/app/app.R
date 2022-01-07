# pixture shiny app

#library(shiny)
#library(pixture)

ids <- c("572897",
          "7604425",
          "4666748",
          "4932184",
          "4210900",
          "3126574",
          "167699",
          "1376201",
          "2437291",
          "1679772",
          "1183099",
          "1813513",
          "931018",
          "267074",
          "4622893")

caption <- c("night;forest;shark;coconut trees;flowers;field;leaves;sunset;mountains;swamp;rainstorm;leaves;beach;leopard;sunflower")

ui <- fluidPage(
    titlePanel("Pixture Demo"),
    sidebarLayout(
        sidebarPanel(width=3,
            selectInput("ids", "Image IDs", choices=ids, selected=ids, multiple=TRUE),
            checkboxInput("caption_check", "Use captions", value=FALSE),
            uiOutput("caption_ui"),
            textInput("h", label = "Image height", value="200px"),
            textInput("w", label = "Image width", value="200px"),
            textInput("gap", label = "Grid gap", value="6px"),
            HTML("Images from <a href='https://unsplash.com/'>Unsplash.</a>")
        ),
        mainPanel(width=9,
            pixture::pixtureOutput("pixture")
        )
    )
)

server <- function(input, output) {
    output$caption_ui <- renderUI({
        if(input$caption_check) {
            textInput("caption", "Caption", value=caption)
        }
    })

    output$pixture <- pixture::renderPixture({
        paths <- paste0("https://images.pexels.com/photos/", input$ids, "/pexels-photo-", input$ids, ".jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")

        if(input$caption_check){
          if(!is.null(input$caption)){
            cpt <- unlist(strsplit(input$caption, ";"))
            if(length(cpt)!=length(paths)) stop("Number of captions do not match number of images.")
            pixture::pixture(paths, caption=cpt, h = input$h, w = input$w, gap = input$gap)
          }
        }else{
            pixture::pixture(paths, h = input$h, w = input$w, gap = input$gap)
        }


    })
}

shinyApp(ui = ui, server = server)
