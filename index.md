# pixture

`pixture` is an R package to create an HTML image gallery. This can be standalone, included in an Rmarkdown document or in a shiny app.

## Installation  

You need to have R (>= 4.0) statistical package installed on your system. [R](https://www.r-project.org/) is open-source and freely available to download for Windows, Mac and other OS.

First install the dependency packages and some helper packages. Then, you can install the package from Github using the `remotes` package. 

```coffee
install.packages(c("htmlwidgets","remotes"))
remotes::install_github('royfrancis/pixture')
```

Once the package is installed, the package is loaded as shown below.

```coffee
# load library
library(pixture)

# check version
packageVersion("pixture")
```

For detailed demonstration and description, refer the vignette.

## Issues/To-do list

- [ ] Local images do not work. Images need to be a web link.
- [ ] Does not work with one image
- [ ] Freewall/Lightbox arguments does not work correctly
- [ ] Fix resizing js error

## Disclaimer

This R package is offered free and without warranty of any kind, either expressed or implied. I will not be held liable to you for any damage arising out of the use, modification or inability to use this program. This R package can be used, redistributed and/or modified freely for non-commercial purposes subject to the original source being properly cited. Licensed under GPL-3.

## Contact

If you have any comments, suggestions, corrections or ideas on ways to improve or extend this package, feel free to contact me. Submit an issue on the [Github issues page](https://github.com/royfrancis/pixture/issues).
