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

expect_silent(pixture(paths))
obj <- pixture(paths)
expect_equal(class(obj),c("pixture","htmlwidget"))
expect_equal(length(obj$x$path),length(paths))

caps <- sample(x=letters,size=length(paths))
obj <- pixture(paths,caption=caps)
expect_equal(length(obj$x$caption),length(paths))
expect_error(pixture(paths,caption=caps[-1]))

expect_error(pixture(paths,options=c("100px")))
