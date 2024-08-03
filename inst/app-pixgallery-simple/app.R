# pixgallery simple shiny app

ids <- c(
  "572897", "7604425", "4666748", "4932184", "4210900", "3126574", "167699",
  "1376201", "2437291", "1679772", "1183099", "1813513", "931018", "267074",
  "4622893", "10519597", "1717071", "1933239", "1374064", "2379653", "845619",
  "2854416", "3540375", "1142984", "1378723", "2033994", "1582818", "1535288"
)
urls <- paste0("https://images.pexels.com/photos/", ids, "/pexels-photo-", ids, ".jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")

ui <- fluidPage(
  titlePanel("Pixgallery"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      textAreaInput("paths", "Image paths", value = paste0(urls, collapse = "\n"), width = "100%", height = "200px"),
      selectInput("layout", label = "Layout", choices = c("grid", "fixed", "mosaic", "masonry", "justified", "elastic", "rhombus"), selected = "grid"),
      HTML("Images from <a href='https://www.pexels.com/'>Pexels.</a>")
    ),
    mainPanel(
      width = 9,
      pixture::pixgalleryOutput("gallery")
    )
  )
)

server <- function(input, output) {
  output$gallery <- pixture::renderPixgallery({
    paths <- unlist(strsplit(input$paths, split = "\\n"))
    pixture::pixgallery(
      paths,
      layout = input$layout
    )
  })
}

shinyApp(ui = ui, server = server)
