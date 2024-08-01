# pixture <img src="logo.webp" style="width:120px;float:right;" align="right" />

[![ci_badge](https://github.com/royfrancis/pixture/workflows/r-cmd-check/badge.svg)](https://github.com/royfrancis/pixture/actions?workflow=r-cmd-check) [![codecov](https://codecov.io/gh/royfrancis/pixture/branch/main/graph/badge.svg?token=4DOQ8HNQFK)](https://app.codecov.io/gh/royfrancis/pixture/) [![lifecycle_badge](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

`pixture` is an R package to create HTML image galleries. This can be standalone, included in an Rmarkdown/Quarto document or in a Shiny app.

## Installation  

You need to have R installed on your system. [R](https://www.r-project.org/) is open-source and freely available to download for Windows, Mac and Linux.

Run the following to install the dependencies and the **pixture** package itself.

```coffee
install.packages(c("htmlwidgets","shiny","remotes"))
remotes::install_github('royfrancis/pixture')
library(pixture)
# packageVersion("pixture")
```

For usage and demonstration, refer to the articles linked in the menu.

## Acknowledgements

- [simplelightbox](https://github.com/dbrekalo/simpleLightbox) created by [Damir Brekalo](https://dbrekalo.github.io/simpleLightbox/).
- Diamond gallery layout based on [this post](https://dev.to/alvaromontoro/creating-an-interactive-image-gallery-with-html-and-css-35pi) by Alvaro Montoro. 
- Images from [Pexels](https://www.pexels.com/).

## Disclaimer

This R package is offered free and without warranty of any kind, either expressed or implied. I will not be held liable to you for any damage arising out of the use, modification or inability to use this program. This R package can be used, redistributed and/or modified freely for non-commercial purposes subject to the original source being properly cited. Licensed under GPL-3.

## Contact

If you have any comments, suggestions, corrections or enchancements, kindly submit an issue on the [Github issues page](https://github.com/royfrancis/pixture/issues).
