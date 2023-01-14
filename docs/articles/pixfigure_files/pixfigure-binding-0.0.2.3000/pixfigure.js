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
  
  let urls = x.path;
  let caption = x.caption;
  let h = x.h;
  let w = x.w;
  let fit = x.fit;
  let position = x.position;

  let temp = '<figure class="pixfigure" id="pixfigure-{id}"><a href="{url}" title="{caption}"><img class="pixfigure-image" style="height:{height};width:{width};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{url}"></a><figcaption>{caption}</figcaption></figure>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    
    if(caption == null || caption[i] == null) {
      newValues += temp.replace("title=\"{caption}\"","").replace("<figcaption>{caption}</figcaption>","").replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{fit\}/g, fit).replace("{position}",position).replace(/\{url\}/g, urls[i]).replace("{id}",el.id);
    } else {
      newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{url\}/g, urls[i]).replace(/\{fit\}/g, fit).replace("{position}",position).replace("{id}",el.id).replace(/\{caption\}/g,caption[i]);
    }
	}
	
  document.getElementById(el.id).innerHTML = '<div class="pixfigure-wrapper">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixfigure-' + el.id + ' a'});
}
