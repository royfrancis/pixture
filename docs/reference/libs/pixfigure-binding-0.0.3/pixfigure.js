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
  
  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var link = x.link;
  var h = x.h;
  var w = x.w;
  var fit = x.fit;
  var position = x.position;
  if(typeof link[0] !== 'boolean') urls = x.link
  
  if(caption.length === 0){
    var temp = '<div class="pixfigure" id="pixfigure-{id}"><a href="{url}"><img class="pixfigure-image" style="height:{h};width:{w};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a></div>';
  } else {
    var temp = '<div class="pixfigure" id="pixfigure-{id}"><a href="{url}" title="{caption}"><img class="pixfigure-image" style="height:{h};width:{w};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a><figcaption>{caption}</figcaption></div>';
  }

	var newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    
    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{h\}/g, h).replace(/\{w\}/g, w).replace(/\{src\}/g, src[i]).replace(/\{fit\}/g, fit).replace("{position}",position)

    // if link is false or url is null, disable link
    if(urls[i]== null || link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("title=\"{caption}\"","")
    } else {
      newValue = newValue.replace(/\{url\}/g, urls[i])
    }

    // if caption is not empty
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i])
    }

    console.log(newValue);
    newValues += newValue.replace(/\{url\}/g, urls[i])
	}
	
  document.getElementById(el.id).innerHTML = '<div class="pixfigure-wrapper">' + newValues + '</div>';
  if(link[0] === true) var lightbox = new SimpleLightbox({elements: '#pixfigure-' + el.id + ' a'});
}
