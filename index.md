# pixture <img src="android-chrome-192x192.png" style="height:96px;" align="right" />

[![ci_badge](https://github.com/royfrancis/pixture/workflows/build/badge.svg)](https://github.com/royfrancis/pixture/actions?workflow=build) [![codecov](https://codecov.io/gh/royfrancis/pixture/branch/main/graph/badge.svg?token=4DOQ8HNQFK)](https://app.codecov.io/gh/royfrancis/pixture/) [![lifecycle_badge](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

`pixture` is an R package to create HTML figures and image galleries. This can be standalone, included in an Rmarkdown document or in a shiny app.

<p style="color: #8a6d3b;background-color: #fcf8e3;border-color:#faebcc;padding: 6px;border-radius: 4px;" style="inline-block">
&nbsp; <i class="fas fa-exclamation-circle"></i> &nbsp; This project is experimental. The functions and arguments are subject to change.
</p>

## Installation  

You need to have R (>= 3.5) installed on your system. [R](https://www.r-project.org/) is open-source and freely available to download for Windows, Mac and other OS.

Run the following to install the dependencies, helper package and pixture package itself.

```coffee
install.packages(c("htmlwidgets","remotes"))
remotes::install_github('royfrancis/pixture')
```

Once the package is installed, the package is loaded for use as shown below.

```coffee
# load library
library(pixture)

# check version
# packageVersion("pixture")
```

For usage and demonstration, refer to the articles linked in the menu.

## Acknowledgements

The lightbox uses [simplelightbox](https://github.com/dbrekalo/simpleLightbox) created by [Damir Brekalo](https://dbrekalo.github.io/simpleLightbox/). Images from [Pexels](https://www.pexels.com/).

## Disclaimer

This R package is offered free and without warranty of any kind, either expressed or implied. I will not be held liable to you for any damage arising out of the use, modification or inability to use this program. This R package can be used, redistributed and/or modified freely for non-commercial purposes subject to the original source being properly cited. Licensed under GPL-3.

## Contact

If you have any comments, suggestions, corrections or enchancements, kindly submit an issue on the [Github issues page](https://github.com/royfrancis/pixture/issues).
