# pixgallery shiny app

ids <- c(
  "572897", "7604425", "4666748", "4932184", "4210900", "3126574", "167699",
  "1376201", "2437291", "1679772", "1183099", "1813513", "931018", "267074",
  "4622893", "10519597", "1717071", "1933239", "1374064", "2379653", "845619",
  "2854416", "3540375", "1142984", "1378723", "2033994", "1582818", "1535288"
)
urls <- paste0("https://images.pexels.com/photos/", ids, "/pexels-photo-", ids, ".jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")
caption <- c("night;forest;shark;coconut trees;flowers;field;misty;leaves;mountains;swamp;rainstorm;leaves;beach;leopard;sunflower;homely;countryside;aurora;cliff;poppy;swan;aerial;snowy;beach;hands;glass;autumn;love")

ui <- fluidPage(
  titlePanel("Pixgallery"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      textAreaInput("paths", "Image paths", value = paste0(urls, collapse = "\n"), width = "100%", height = "200px"),
      textInput("sep", "Separator", value = "\\n"),
      hr(),
      checkboxInput("caption_check", "Use captions", value = FALSE),
      uiOutput("caption_ui"),
      hr(),
      checkboxInput("link", "Use lightbox", value = TRUE),
      selectInput("layout", label = "Layout", choices = c("grid", "fixed", "mosaic", "masonry", "justified", "elastic", "rhombus"), selected = "grid"),
      textInput("h", label = "Height", value = "120px"),
      textInput("w", label = "Width", value = "120px"),
      textInput("gap", label = "Grid gap", value = "4px"),
      textInput("border_radius", label = "Border radius", value = "0px"),
      checkboxInput("shuffle", "Shuffle", value = FALSE),
      HTML("Images from <a href='https://www.pexels.com/'>Pexels.</a>")
    ),
    mainPanel(
      width = 9,
      pixture::pixgalleryOutput("gallery")
    )
  )
)

server <- function(input, output) {
  output$caption_ui <- renderUI({
    if (input$caption_check) {
      div(
        textInput("caption", "Caption", value = caption),
        selectInput("valign", "Vertical alignment", choices = c("none", "top", "center", "bottom", "below")),
        selectInput("halign", "Horiz alignment", choices = c("left", "center", "right")),
      )
    }
  })

  output$gallery <- pixture::renderPixgallery({
    paths <- unlist(strsplit(input$paths, split = input$sep))

    if (input$caption_check) {
      if (!is.null(input$caption)) {
        cpt <- unlist(strsplit(input$caption, ";"))
        if (length(cpt) != length(paths)) stop("Number of captions do not match number of images.")
        pixture::pixgallery(paths, caption = cpt, caption_valign = input$valign, caption_halign = input$halign, link = input$link, h = input$h, w = input$w, gap = input$gap, border_radius = input$border_radius, layout = input$layout, shuffle = input$shuffle)
      }
    } else {
      pixture::pixgallery(paths, link = input$link, h = input$h, w = input$w, gap = input$gap, border_radius = input$border_radius, layout = input$layout, shuffle = input$shuffle)
    }
  })
}

shinyApp(ui = ui, server = server)
