# pixture 0.2.1

- 09-Nov-2025
- Pixcarousel
  - Added new parameters `fit` and `position`
  - Moved carousel buttons to bottom, dots hidden for narrow screens
  - Corrected caption overlay when using `gap` parameter
- Added 'caption_lightbox' parameter to set different captions in lightbox
- Improved shuffle option to work with captions, links and lightbox captions
- Added showcase 'furniture' to documentation

# pixture 0.2.0

- 04-Nov-2025
- Replaced simplelightbox with glightbox
- Added new function `pixcarousel()` to create image carousels
- Added new layouts 'scroll' and 'hexagon' to pixgallery
- Improved 'rhombus' layout with size, gap, border radius and captions
- Added shiny app demo for pixcarousel
- Updated vignettes
- Removed deprecated arguments 'type' and 'dim' from `pixgallery()`

# pixture 0.1.0

- 03-Aug-2024
- Pixgallery
  - Split parameter 'dim' into 'h' and 'w'
  - Added parameters 'caption_valign', 'caption_halign', 'link', 'border_radius'
  - Parameter 'type' changed to 'layout'
  - Added more layouts: fixed, mosaic, masonry, justified, elastic, rhombus
- Pixfigure
  - Added parameter 'link'
- Updated shiny demo apps and added run functions
- Updated logo
- Updated vignettes to quarto
- Updated tests
- Add showcase: ferns, cities to documentation
- Combined shiny apps into single launcher `launchApp()`
- Fixed caption overflow in masonry
- Justified layout without caption is now full width
- Grid layout height can be adjusted

# pixture 0.0.2.3000

- 14-Jan-2023
- Added shuffle option (Thanks to @Enchufa2)

# pixture 0.0.2.2001

- 06-Jul-2022
- Minor updates to function help and vignettes

# pixture 0.0.2.2000

- 17-Jan-2022
- Logo updated
- pixfigure() takes multiple images
- Theme and color updates

# pixture 0.0.2.1000

- 16-Jan-2022
- R dependency changed from 3.5 to 3.6
- Logo updated

# pixture 0.0.2.0000

- 16-Jan-2022
- Renamed pixture() function to pixgallery()
- Defined gallery as separate function and widget
- Gallery using flexbox or grid using img tag
- Added pixfigure() for single images

# pixture 0.0.1.0000

- 07-Jan-2022
- Dropped freewall, lightbox and jquery
- Gallery using flex-grid
- Lightbox using simplelightbox
- Gallery with single image fixed

# pixture 0.0.0.9000

* 25-Oct-2021
* the first version of the package
