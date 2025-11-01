# pixgallery shiny app

ids <- c(
  "572897",
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
  "4622893",
  "10519597",
  "1717071",
  "1933239",
  "1374064",
  "2379653",
  "845619",
  "2854416",
  "3540375",
  "1142984",
  "1378723",
  "2033994",
  "1582818",
  "1535288"
)
urls <- paste0(
  "https://images.pexels.com/photos/",
  ids,
  "/pexels-photo-",
  ids,
  ".jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
)

captions_short <- c(
  "night",
  "forest",
  "shark",
  "coconut trees",
  "flowers",
  "field",
  "misty",
  "leaves",
  "mountains",
  "swamp",
  "rainstorm",
  "leaves",
  "beach",
  "leopard",
  "sunflower",
  "homely",
  "countryside",
  "aurora",
  "cliff",
  "poppy",
  "swan",
  "aerial",
  "snowy",
  "beach",
  "hands",
  "glass",
  "autumn",
  "love"
)

captions_long <- c(
  "The night sky blanketed the quiet village as stars twinkled in the peaceful darkness.",
  "A stroll through the forest reveals nature's hidden gems and the call of wild creatures.",
  "Snorkeling with a shark is an unforgettable experience for adventure seekers and marine life lovers.",
  "Sipping coconut water on a hammock under swaying palms is pure tropical bliss.",
  "Blooming flowers in the meadow create a splash of color and a perfect photo opportunity.",
  "Children laughed and played in the vast field of golden wheat under the summer sun.",
  "Misty mornings in the valley offer a surreal, almost dreamlike atmosphere to early risers.",
  "Autumn leaves crunch underfoot as you hike through the serene woodland trails.",
  "Snow-capped mountains tower majestically over the valley below, inviting explorers to their icy peaks.",
  "The dense swamp is teeming with life, from croaking frogs to towering mangroves.",
  "Caught in a rainstorm, we sought shelter under an old oak tree on the path.",
  "The thick canopy of leaves shields forest walkers from the midday sun's strong rays.",
  "Crystal-clear waters and white sands define the idyllic, unspoiled beach destination of your dreams.",
  "A graceful leopard prowls silently, blending with the shadows of the African savannah.",
  "Sunflowers turn their faces to the sun, creating a stunning, golden sea under the blue sky.",
  "The homely farmhouse offered warmth and comfort during our countryside get-away from city life.",
  "The countryside is a tranquil escape with picturesque views and a slower pace of life.",
  "The aurora borealis paint the night sky with a mesmerizing dance of colors and light.",
  "Standing on the cliff's edge, you can feel the powerful wind and see endless horizons.",
  "A field of poppies sways gently in the breeze, a red tide against the green landscape.",
  "A regal swan glides across the lake, leaving ripples in its calm, reflective surface.",
  "An aerial view reveals the breathtaking expanse of the Grand Canyon's layered, rugged landscape.",
  "Snowy plains stretch out beneath the blue sky, a pristine winter wonderland inviting exploration.",
  "Sun kissed sands and azure waters make any beach visit an unforgettable escape from reality.",
  "Hands clasped together, we felt the strong connection that makes this journey even more special.",
  "The glass facade of modern skyscrapers reflects the amazing energy of the bustling city life.",
  "Leaves spiral down in the crisp autumn air, covering the ground in a crunchy carpet.",
  "Love blossoms in the most unexpected places, turning an adventure into a memorable journey."
)

ui <- fluidPage(
  titlePanel("Pixgallery"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      textAreaInput(
        "paths",
        "Image paths",
        value = paste0(urls, collapse = "\n"),
        width = "100%",
        height = "200px"
      ),
      hr(),
      selectInput(
        "caption_check",
        "Use captions",
        choices = c("None", "Short", "Long"),
        selected = "None"
      ),
      uiOutput("caption_ui"),
      hr(),
      checkboxInput("link", "Use lightbox", value = TRUE),
      selectInput(
        "layout",
        "Layout",
        choices = c(
          "grid",
          "fixed",
          "mosaic",
          "masonry",
          "justified",
          "elastic",
          "rhombus",
          "scroll"
        ),
        selected = "grid"
      ),
      sliderInput("h", "Height", min = 10, max = 500, step = 5, value = 120),
      sliderInput("w", "Width", min = 10, max = 500, step = 5, value = 120),
      sliderInput("gap", "Grid gap", min = 0, max = 30, step = 1, value = 4),
      sliderInput(
        "border_radius",
        "Border radius",
        min = 0,
        max = 50,
        step = 1,
        value = 0
      ),
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
    if (input$caption_check != "None") {
      captions <- ifelse(
        input$caption_check == "Short",
        paste0(captions_short, collapse = "\n"),
        paste0(captions_long, collapse = "\n")
      )
      div(
        textAreaInput(
          "caption",
          "Caption",
          value = captions,
          width = "100%",
          height = "150px"
        ),
        selectInput(
          "valign",
          "Vertical alignment",
          choices = c("none", "top", "center", "bottom", "below")
        ),
        selectInput(
          "halign",
          "Horiz alignment",
          choices = c("left", "center", "right")
        ),
      )
    }
  })

  output$gallery <- pixture::renderPixgallery({
    paths <- unlist(strsplit(input$paths, split = "\\n"))

    if (input$caption_check != "None") {
      if (!is.null(input$caption)) {
        cpt <- unlist(strsplit(input$caption, split = "\\n"))
        if (length(cpt) != length(paths)) {
          stop("Number of captions do not match number of images.")
        }
        pixture::pixgallery(
          paths,
          caption = cpt,
          caption_valign = input$valign,
          caption_halign = input$halign,
          link = input$link,
          h = paste0(input$h, "px"),
          w = paste0(input$w, "px"),
          gap = paste0(input$gap, "px"),
          border_radius = paste0(input$border_radius, "px"),
          layout = input$layout,
          shuffle = input$shuffle
        )
      }
    } else {
      pixture::pixgallery(
        paths,
        link = input$link,
        h = paste0(input$h, "px"),
        w = paste0(input$w, "px"),
        gap = paste0(input$gap, "px"),
        border_radius = paste0(input$border_radius, "px"),
        layout = input$layout,
        shuffle = input$shuffle
      )
    }
  })
}

shinyApp(ui = ui, server = server)
