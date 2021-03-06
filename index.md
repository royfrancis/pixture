# pixture <img src="android-chrome-192x192.png" style="height:96px;" align="right" />

[![ci_badge](https://github.com/royfrancis/pixture/workflows/r-cmd-check/badge.svg)](https://github.com/royfrancis/pixture/actions?workflow=r-cmd-check) [![codecov](https://codecov.io/gh/royfrancis/pixture/branch/main/graph/badge.svg?token=4DOQ8HNQFK)](https://app.codecov.io/gh/royfrancis/pixture/) [![lifecycle_badge](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

`pixture` is an R package to create HTML figures and image galleries. This can be standalone, included in an Rmarkdown document or in a Shiny app.

<p style="color: #8a6d3b;background-color: #fcf8e3;border-color:#faebcc;padding: 6px;border-radius: 4px;" style="inline-block">
&nbsp; <i class="fas fa-exclamation-circle"></i> &nbsp; This project is experimental. The functions and arguments are subject to change.
</p>

## Installation  

You need to have R installed on your system. [R](https://www.r-project.org/) is open-source and freely available to download for Windows, Mac and Linux.

Run the following to install the dependencies and the **pixture** package itself.

```coffee
install.packages(c("htmlwidgets","shiny","remotes"))
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

This package uses [simplelightbox](https://github.com/dbrekalo/simpleLightbox) created by [Damir Brekalo](https://dbrekalo.github.io/simpleLightbox/). Images from [Pexels](https://www.pexels.com/).

## Disclaimer

This R package is offered free and without warranty of any kind, either expressed or implied. I will not be held liable to you for any damage arising out of the use, modification or inability to use this program. This R package can be used, redistributed and/or modified freely for non-commercial purposes subject to the original source being properly cited. Licensed under GPL-3.

## Contact

If you have any comments, suggestions, corrections or enchancements, kindly submit an issue on the [Github issues page](https://github.com/royfrancis/pixture/issues).
