HTMLWidgets.widget({

  name: 'pixfigure',
  type: 'output',

  factory: function(el, width, height) {

    /* TODO: define shared variables for this instance */

    return {
      renderValue: function(opts) {
        pixfigure_basic(el,opts);
      },
      resize: function(width, height) {
        /* TODO: code to re-render the widget with a new size */
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
  if(typeof link[0] !== 'boolean') urls = link;
  
  if(caption.length === 0){

      var temp = '<div class="pixfigure" id="pixfigure-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixfigure-image" style="height:{h};width:{w};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a></div>';
    
  } else {

    var temp = '<div class="pixfigure" id="pixfigure-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixfigure-image" style="height:{h};width:{w};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a><figcaption>{caption}</figcaption></div>';

  }

	var newValues = '', limitItem = src.length;
	for (let i = 0; i < limitItem; ++i) {
    
    let newValue = '';
    newValue = temp.replace(/\{id\}/g, el.id).replace(/\{h\}/g, h).replace(/\{w\}/g, w).replace(/\{src\}/g, src[i]).replace(/\{fit\}/g, fit).replace("{position}",position)

    /* Link based fix */
    if(typeof link[0] !== 'boolean'){
      newValue = newValue.replace("class=\"glightbox\"","target=\"_blank\"")
    } else if (typeof(link[0]) == 'boolean' && link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("class=\"glightbox\"","")
    }

    /* If caption is not empty */
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i])
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
	}
	
  document.getElementById(el.id).innerHTML = '<div class="pixfigure-wrapper">' + newValues + '</div>';
  
  if(link[0] === true) {
    const lightbox_options = Object.assign(x.lightbox || {});
    const lightbox = GLightbox(lightbox_options);
  }
}
