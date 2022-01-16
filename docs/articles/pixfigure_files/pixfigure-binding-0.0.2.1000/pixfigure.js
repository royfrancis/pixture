HTMLWidgets.widget({

  name: 'pixfigure',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {
      renderValue: function(opts) {
        pixfigure_basic(el,opts);
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});

function pixfigure_basic(el,x){
  let url = x.path;
  let caption = x.caption;
  let h = x.h;
  let w = x.w;
  let fit = x.fit;
  let position = x.position;

  let value = '<figure class="pixfigure" id="pixfigure-' + el.id + '"><a href="' + url +'" title="{caption}"><img class="pixfigure-image" style="height:' + h + ';width:' + w + ';object-fit:' + fit + ';-o-object-fit:' + fit + ';object-position:' + position + ';" src="' + url + '"></a><figcaption>{caption}</figcaption></figure>';

  if(caption === null) {
    value = value.replace("title=\"{caption}\"","").replace("<figcaption>{caption}</figcaption>","");
  } else {
    value = value.replace("{caption}",caption).replace("{caption}",caption);
  }

	document.getElementById(el.id).innerHTML = value;
  var lightbox = new SimpleLightbox({elements: '#pixfigure-' + el.id + ' a'});
}
