# pixgallery shiny app

#library(shiny)
#library(pixture)

ids <- c("572897","7604425","4666748","4932184","4210900","3126574","167699",
         "1376201","2437291","1679772","1183099","1813513","931018","267074",
         "4622893","10519597","1717071","1933239","1374064","2379653","845619",
         "2854416","3540375","1142984","1378723","2033994","1582818","1535288")

caption <- c("night;forest;shark;coconut trees;flowers;field;misty;leaves;mountains;swamp;rainstorm;leaves;beach;leopard;sunflower;homely;countryside;aurora;cliff;poppy;swan;aerial;snowy;beach;hands;glass;autumn;love")

ui <- fluidPage(
    titlePanel("Pixgallery Demo"),
    sidebarLayout(
        sidebarPanel(width=3,
            selectInput("ids", "Image IDs", choices=ids, selected=ids, multiple=TRUE),
            checkboxInput("caption_check", "Use captions", value=FALSE),
            uiOutput("caption_ui"),
            textInput("dim", label = "Dimension", value="120px"),
            textInput("gap", label = "Grid gap", value="4px"),
            HTML("Images from <a href='https://www.pexels.com/'>Pexels.</a>")
        ),
        mainPanel(width=9,
            pixture::pixgalleryOutput("gallery")
        )
    )
)

server <- function(input, output) {
    output$caption_ui <- renderUI({
        if(input$caption_check) {
            textInput("caption", "Caption", value=caption)
        }
    })

    output$gallery <- pixture::renderPixgallery({
        paths <- paste0("https://images.pexels.com/photos/", input$ids, "/pexels-photo-", input$ids, ".jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")

        if(input$caption_check){
          if(!is.null(input$caption)){
            cpt <- unlist(strsplit(input$caption, ";"))
            if(length(cpt)!=length(paths)) stop("Number of captions do not match number of images.")
            pixture::pixgallery(paths, caption=cpt, dim = input$dim, gap = input$gap)
          }
        }else{
            pixture::pixgallery(paths, dim = input$dim, gap = input$gap)
        }


    })
}

shinyApp(ui = ui, server = server)
