# Test Script

library(testthat)
library(pixture)
#devtools::test()

# get paths
paths <- c("https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/7604425/pexels-photo-7604425.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4666748/pexels-photo-4666748.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4932184/pexels-photo-4932184.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4210900/pexels-photo-4210900.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/3126574/pexels-photo-3126574.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1376201/pexels-photo-1376201.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/7919/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/2437291/pexels-photo-2437291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1679772/pexels-photo-1679772.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1183099/pexels-photo-1183099.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/1813513/pexels-photo-1813513.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/931018/pexels-photo-931018.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/267074/pexels-photo-267074.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
           "https://images.pexels.com/photos/4622893/pexels-photo-4622893.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")

# pixgallery -------------------------------------------------------------------

# empty input
expect_error(pixgallery())
expect_silent(pixgallery(paths))
obj <- pixgallery(paths)
# pixgallery class
expect_equal(class(obj),c("pixgallery","htmlwidget"))
expect_equal(length(obj$x$path),length(paths))

# test captions
caps <- sample(x=letters,size=length(paths))
obj <- pixgallery(paths,caption=caps)
expect_equal(length(obj$x$caption),length(paths))
# error if caption length is incorrect
expect_error(pixgallery(paths,caption=caps[-1]))
# if caption has NA
caps[2] <- NA
expect_silent(pixgallery(paths,caption=caps))
# captions as path names
names(paths) <- caps
expect_silent(pixgallery(paths))
# captions both as names and caption argument
expect_silent(pixgallery(paths,caption=caps))

# dimensions
expect_silent(pixgallery(paths,dim="100px"))
expect_silent(pixgallery(paths,gap="10px"))
expect_silent(pixgallery(paths,dim="2em"))
expect_silent(pixgallery(paths,dim="50px",gap="5px"))

# pixfigure --------------------------------------------------------------------

# empty input
expect_error(pixfigure())
expect_error(pixfigure(paths))
expect_silent(pixfigure(paths[1]))
obj <- pixfigure(paths[1])
# pixfigure class
expect_equal(class(obj),c("pixfigure","htmlwidget"))

# test captions
caps <- sample(x=letters,size=length(paths))
expect_silent(pixfigure(paths[1],caption=caps[1]))
# captions as path names
names(paths) <- caps
expect_silent(pixgallery(paths[1]))
# captions both as names and caption argument
expect_silent(pixfigure(paths[1],caption=caps[1]))

# dimensions
expect_silent(pixfigure(paths[1],height="200px"))
expect_silent(pixfigure(paths[1],height="100vh"))
expect_silent(pixfigure(paths[1],width="8em"))

# fit
expect_silent(pixfigure(paths[1],fit="fill"))
# position
expect_silent(pixfigure(paths[1],position="right"))
