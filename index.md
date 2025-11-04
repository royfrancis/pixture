# pixture <img src="logo.webp" alt="pixture-logo" style="width:120px;float:right;" align="right" />

[![ci_badge](https://github.com/royfrancis/pixture/workflows/r-cmd-check/badge.svg)](https://github.com/royfrancis/pixture/actions?workflow=r-cmd-check) [![codecov](https://codecov.io/gh/royfrancis/pixture/branch/main/graph/badge.svg?token=4DOQ8HNQFK)](https://app.codecov.io/gh/royfrancis/pixture/) [![r-universe status](https://royfrancis.r-universe.dev/pixture/badges/checks)](https://royfrancis.r-universe.dev/pixture) [![r-universe version](https://royfrancis.r-universe.dev/pixture/badges/version)](https://royfrancis.r-universe.dev/pixture) 

`pixture` is an R package designed to create HTML image galleries. The galleries can be standalone, included in an Rmarkdown/Quarto document or incorporated into a Shiny app.

## Features

![](man/figures/concept.webp)

- Create image galleries with multiple layouts: grid, mosaic, masonry, justified, elastic, rhombus, scroll and hexagon
- Create image carousels with touch and drag support
- Lightbox support with captions and navigation
- Customizable captions, borders, gaps, and more

## Installation  

Ensure you have R installed on your system. [R](https://www.r-project.org/) is open-source and freely available to download for Windows, Mac and Linux.

Install from **R Universe**:

```r
options(repos = c(getOption("repos"), royfrancis = "https://royfrancis.r-universe.dev"))
install.packages('pixture')
```

Install from **GitHub**:

```r
install.packages(c("htmlwidgets","shiny","remotes"))
remotes::install_github('royfrancis/pixture')
```

For usage and demonstrations, refer to the articles linked in the menu.

## Acknowledgements

- [glider.js](https://nickpiscitelli.github.io/Glider.js/) by Nick Piscitelli for carousel functionality
- [glightbox](https://github.com/biati-digital/glightbox) by [Biati Digital](https://www.biati.com.mx/) for lightbox functionality
- Rhombus and Hexagon gallery layout by [Temani Afif](https://css-tricks.com/hexagons-and-beyond-flexible-responsive-grid-patterns-sans-media-queries/)
- Images from [Pexels](https://www.pexels.com/)

## Disclaimer

This R package is offered free and without warranty of any kind, either expressed or implied. I will not be held liable to you for any damage arising out of the use, modification or inability to use this program. This R package can be used, redistributed and/or modified freely for non-commercial purposes subject to the original source being properly cited. Licensed under GPL-3.

## Contact

If you have any comments, suggestions, corrections or enchancements, kindly submit an issue on the [Github issues page](https://github.com/royfrancis/pixture/issues).
