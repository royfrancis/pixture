HTMLWidgets.widget({

  name: 'pixgallery',
  type: 'output',

  factory: function(el, width, height) {

    /* TODO: define shared variables for this instance */

    return {
      renderValue: function(opts) {
        pixgallery_base(el,opts);
      },
      resize: function(width, height) {
        /* TODO: code to re-render the widget with a new size */
      }
    };
  }
});

function shuffle(obj1, obj2) {
  var index = obj1.length;
  var rnd, tmp1, tmp2;

  while (index) {
    rnd = Math.floor(Math.random() * index);
    index -= 1;
    tmp1 = obj1[index];
    tmp2 = obj2[index];
    obj1[index] = obj1[rnd];
    obj2[index] = obj2[rnd];
    obj1[rnd] = tmp1;
    obj2[rnd] = tmp2;
  }
}

/* Function to switch flexbox caption alignment */
function getFlexCaptionAlign(x) {
  switch (x) {
    case "top":
      return "flex-start";
    case "center":
      return "center";
    case "bottom":
      return "flex-end";
    default:
      return "none";
  }
}

/* Function to switch css grid caption alignment */
function getGridCaptionAlign(x) {
  switch (x) {
    case "top":
      return "start";
    case "center":
      return "center";
    case "bottom":
      return "end";
    default:
      return "none";
  }
}

function pixgallery_base(el,x){
  if(x.shuffle) shuffle(x.path, x.caption);
  if(x.layout === "grid") {
    var fixed = false;
    pixgallery_grid(el,x,fixed);
  }
  if(x.layout === "fixed") {
    var fixed = true;
    pixgallery_grid(el,x,fixed);
  }
  if(x.layout === "masonry") pixgallery_masonry(el,x);
  if(x.layout === "justified") pixgallery_justified(el,x);
  if(x.layout === "elastic") pixgallery_elastic(el,x);
  if(x.layout === "mosaic") pixgallery_mosaic(el,x);
  if(x.layout === "rhombus") pixgallery_rhombus(el,x);
  if(x.layout === "scroll") pixgallery_scroll(el,x);
  if(x.layout === "hexagon") pixgallery_hexagon(el,x);
}

/* grid --------------------------------------------------------------------- */

function pixgallery_grid(el,x,fixed){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var h = x.h;
  var w = x.w;
  var gap = x.gap;
  var borderRadius = x.border_radius;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";
  if(w === null) w = "200px";

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-grid-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-grid-image" style="border-radius:{borderRadius};height:{h};" src="{src}"></a></div>';

  } else {
    if(captionValign == "none"){

      /* If captions are not displayed */
      var temp = '<div class="pixgallery-child pixgallery-grid-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image" style="border-radius:{borderRadius};height:{h};" src="{src}"></a></div>';

    } else if(captionValign == "below") {

      if(fixed) {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-below" id="pixgallery-{id}" style="grid-template-rows:{h} 1fr;"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-below" style="border-radius:{borderRadius} {borderRadius} 0 0;height:{h};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-below" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      } else {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-grid-child-below" id="pixgallery-{id}" style="grid-template-rows:{h} 1fr;"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-below" style="border-radius:{borderRadius} {borderRadius} 0 0;height:{h};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-below" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      }
      
    } else if(captionValign == "top") {

      if(fixed) {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-over" style="border-radius:{borderRadius};height:{h};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-top" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      } else {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-over" style="border-radius:{borderRadius};height:100%;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-top" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      }
      
    } else if(captionValign == "center") {

      if(fixed) {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-over" style="border-radius:{borderRadius};height:{h};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-center" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      } else {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-over" style="border-radius:{borderRadius};height:100%;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-center" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      }

    } else {

      if(fixed) {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-over" style="border-radius:{borderRadius};height:{h};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-bottom" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      } else {
        var temp = '<div class="pixgallery-child pixgallery-grid-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-grid-image pixgallery-grid-image-over" style="border-radius:{borderRadius};height:100%;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-bottom" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      }
    }
  }

  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace(/\{id\}/g, el.id).replace(/\{h\}/g, h).replace(/\{w\}/g, w).replace(/\{borderRadius\}/g, borderRadius).replace(/\{src\}/g, src[i]).replace(/\{min-height\}/g, h)

    /* Link based fix */
    if(typeof link[0] !== 'boolean'){
      newValue = newValue.replace("class=\"glightbox\"","target=\"_blank\"")
    } else if (typeof(link[0]) == 'boolean' && link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("class=\"glightbox\"","")
    }

    /* If caption is not empty */
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i]).replace(/\{captionHalign\}/g, captionHalign)
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
  }

  if(fixed) {
    document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-grid" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, ' + w + ');' + '">' + newValues + '</div>';
  } else {
    if(captionValign == "none") {
      document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-grid" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + w + ',1fr));grid-auto-rows:' + h + ';">' + newValues + '</div>';
    } else if(captionValign == "below") {
      document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-grid" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + w + ',1fr));">' + newValues + '</div>';
    } else {
      document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-grid" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + w + ',1fr));grid-auto-rows: minmax(' + h + ',1fr);">' + newValues + '</div>';
    }
  }

  if(link[0] === true) {
    const lightbox_options = Object.assign(x.lightbox || {});
    const lightbox = GLightbox(lightbox_options);
  }
}

/* mosaic ------------------------------------------------------------------- */

function pixgallery_mosaic(el,x){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var h = x.h;
  var w = x.w;
  var gap = x.gap;
  var borderRadius = x.border_radius;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";
  if(w === null) w = "200px";

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-mosaic-child pixgallery-mosaic-child" id="pixgallery-{id}"><a class="glightbox" data-gallery="{id}" href="{url}"><img class="pixgallery-mosaic-image" style="border-radius:{borderRadius};" src="{src}"></a></div>';

  } else {
    if(captionValign == "none"){

    /* If captions are not displayed */
    var temp = '<div class="pixgallery-child pixgallery-mosaic-child pixgallery-mosaic-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-mosaic-image" style="border-radius:{borderRadius};" src="{src}"></a></div>';

    } else if(captionValign == "below") {

    var temp = '<div class="pixgallery-child pixgallery-mosaic-child pixgallery-mosaic-child pixgallery-mosaic-child-below" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-mosaic-image" style="border-radius:{borderRadius} {borderRadius} 0 0;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-below" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';

      
    } else if(captionValign == "top") {

    var temp = '<div class="pixgallery-child pixgallery-mosaic-child pixgallery-mosaic-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-mosaic-image" style="border-radius:{borderRadius};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-top" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      
    } else if(captionValign == "center") {

    var temp = '<div class="pixgallery-child pixgallery-mosaic-child pixgallery-mosaic-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-mosaic-image" style="border-radius:{borderRadius};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-center" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else {

    var temp = '<div class="pixgallery-child pixgallery-mosaic-child pixgallery-mosaic-child pixgallery-child-over" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-mosaic-image" style="border-radius:{borderRadius};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-bottom" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    }
  }

  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{h\}/g, h).replace(/\{w\}/g, w).replace(/\{borderRadius\}/g, borderRadius).replace(/\{src\}/g, src[i]).replace(/\{min-height\}/g, h)

    /* Link based fix */
    if(typeof link[0] !== 'boolean'){
      newValue = newValue.replace("class=\"glightbox\"","target=\"_blank\"")
    } else if (typeof(link[0]) == 'boolean' && link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("class=\"glightbox\"","")
    }

    /* If caption is not empty */
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i]).replace(/\{captionHalign\}/g, captionHalign)
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
  }

  if(captionValign == "none") {
    document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-mosaic" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + w + ',1fr));grid-auto-rows:' + h + ';">' + newValues + '</div>';
  } else {
    document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-mosaic" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + w + ',1fr));">' + newValues + '</div>';
  }

  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }
}

/* masonry ------------------------------------------------------------------ */

function pixgallery_masonry(el,x){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var w = x.w;
  var gap = x.gap;
  var borderRadius = x.border_radius;

  if(typeof link[0] !== 'boolean') urls = link
  if(w === null) w = "200px";

    /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-masonry-child" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-masonry-image" style="border-radius:{borderRadius};" src="{src}"></a></div>';

  } else {

    if(captionValign == "none"){

      /* If captions are not displayed */
      var temp = '<div class="pixgallery-child pixgallery-masonry-child" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-masonry-image" style="border-radius:{borderRadius};" src="{src}"></a></div>';

    } else if(captionValign == "below") {

      var temp = '<div class="pixgallery-child pixgallery-masonry-child pixgallery-child-below" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-masonry-image" style="border-radius:{borderRadius} {borderRadius} 0 0;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-below" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else if(captionValign == "top") {

      var temp = '<div class="pixgallery-child pixgallery-masonry-child pixgallery-child-over" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-masonry-image" style="border-radius:{borderRadius}; height:100%;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-top" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else if(captionValign == "center") {

      var temp = '<div class="pixgallery-child pixgallery-masonry-child pixgallery-child-over" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-masonry-image" style="border-radius:{borderRadius}; height:100%;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-center" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else {

      var temp = '<div class="pixgallery-child pixgallery-masonry-child pixgallery-child-over" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-masonry-image" style="border-radius:{borderRadius}; height:100%;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-bottom" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
    }
  }

  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{w\}/g, w).replace(/\{borderRadius\}/g, borderRadius).replace(/\{src\}/g, src[i]).replace(/\{gap\}/g, gap)

    /* Link based fix */
    if(typeof link[0] !== 'boolean'){
      newValue = newValue.replace("class=\"glightbox\"","target=\"_blank\"")
    } else if (typeof(link[0]) == 'boolean' && link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("class=\"glightbox\"","")
    }

    /* If caption is not empty */
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i]).replace(/\{captionHalign\}/g, captionHalign)
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
  }

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-masonry" style="column-gap:' + gap + ';column-width:' + w + ';">' + newValues + '</div>';
  
  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }
}

/* justified ---------------------------------------------------------------- */

function pixgallery_justified(el,x){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var h = x.h;
  var gap = x.gap;
  var borderRadius = x.border_radius;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-justified-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-justified-image" style="height:{h};border-radius:{borderRadius};" src="{src}"></a></div>';

  } else {
    if(captionValign == "none"){

      /* If captions are not displayed */
      var temp = '<div class="pixgallery-child pixgallery-justified-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-justified-image" style="height:{h};border-radius:{borderRadius};" src="{src}"></a></div>';

    } else  if(captionValign == "below") {

      var temp = '<div class="pixgallery-child pixgallery-justified-child pixgallery-child-below" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-justified-image" style="height:{h};border-radius:{borderRadius} {borderRadius} 0 0;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-below" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else if(captionValign == "top") {

      var temp = '<div class="pixgallery-child pixgallery-justified-over-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}" style="height:{h};"><img class="pixgallery-justified-over-image" style="border-radius:{borderRadius};" src="{src}"></a><div class="pixgallery-caption pixgallery-justified-caption-top" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else if(captionValign == "center") {

      var temp = '<div class="pixgallery-child pixgallery-justified-over-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}" style="height:{h};"><img class="pixgallery-justified-over-image" style="border-radius:{borderRadius};" src="{src}"></a><div class="pixgallery-caption pixgallery-justified-caption-center" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';

    } else {

      var temp = '<div class="pixgallery-child pixgallery-justified-over-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}" style="height:{h};"><img class="pixgallery-justified-over-image" style="border-radius:{borderRadius};" src="{src}"></a><div class="pixgallery-caption pixgallery-justified-caption-bottom" style="border-radius:{borderRadius};text-align:{captionHalign};">{caption}</div></div>';
    }
  }
  
  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{h\}/g, h).replace(/\{borderRadius\}/g, borderRadius).replace(/\{src\}/g, src[i]).replace(/\{gap\}/g, gap)

    /* Link based fix */
    if(typeof link[0] !== 'boolean'){
      newValue = newValue.replace("class=\"glightbox\"","target=\"_blank\"")
    } else if (typeof(link[0]) == 'boolean' && link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("class=\"glightbox\"","")
    }

    /* If caption is not empty */
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i]).replace(/\{captionHalign\}/g, captionHalign)
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
  }

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-justified" style="gap:' + gap + ';">' + newValues + '</div>';
  
  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }
}

/* elastic ------------------------------------------------------------------ */

function pixgallery_elastic(el,x){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var link = x.link;
  var h = x.h;
  var gap = x.gap;
  var borderRadius = x.border_radius;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";

    /* Initialize template */
  if(caption.length === 0){
    var temp = '<div class="pixgallery-child pixgallery-elastic-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-elastic-image" style="border-radius:{borderRadius};" src="{src}"></a></div>';
  } else {
    var temp = '<div class="pixgallery-child pixgallery-elastic-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-elastic-image" style="border-radius:{borderRadius};" src="{src}"></a></div>';
  }
  
  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{h\}/g, h).replace(/\{borderRadius\}/g, borderRadius).replace(/\{src\}/g, src[i]).replace(/\{gap\}/g, gap)

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

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-elastic" style="height:' + h + ';gap:' + gap + ';">' + newValues + '</div>';
  
  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }
}

/* rhombus ------------------------------------------------------------------ */
/* Function to create rhombus polygon with border radius */
function createRoundedRhombus(size, radius) {
  /* Parse size (assume pixels if no unit provided) */
  const sizeValue = typeof size === 'number' ? size : parseFloat(size);
  
  /* Parse radius and convert to pixels relative to size */
  let radiusValue;
  if (typeof radius === 'number') {
    radiusValue = radius;
  } else if (typeof radius === 'string') {
    const match = radius.match(/^([\d.]+)(.*)$/);
    if (match) {
      const value = parseFloat(match[1]);
      const unit = match[2] || 'px';
      
      /* Convert different units to pixels relative to size */
      switch(unit) {
        case 'px':
          radiusValue = value;
          break;
        case '%':
          radiusValue = (value / 100) * sizeValue;
          break;
        case 'em':
        case 'rem':
          radiusValue = value * 16;
          break;
        default:
          radiusValue = value;
      }
    }
  }
  
  const width = sizeValue;
  const height = sizeValue;
  const cx = width / 2;
  const cy = height / 2;
  
  /* The 4 corner points of the rhombus (diamond) */
  const points = [
    { x: cx, y: 0 },
    { x: width, y: cy },
    { x: cx, y: height },
    { x: 0, y: cy }
  ];
  
  /* Calculate the distance to offset from each corner along the edges for rounding */
  /* For a rhombus, each edge has the same length */
  const edgeLength = Math.sqrt(Math.pow(cx, 2) + Math.pow(cy, 2));
  const offset = radiusValue / edgeLength;
  
  let path = '';
  
  for (let i = 0; i < points.length; i++) {
    const current = points[i];
    const next = points[(i + 1) % points.length];
    const prev = points[(i - 1 + points.length) % points.length];
    
    /* Vector from current to next */
    const dx1 = next.x - current.x;
    const dy1 = next.y - current.y;
    const len1 = Math.sqrt(dx1 * dx1 + dy1 * dy1);
    
    /* Vector from current to previous */
    const dx2 = prev.x - current.x;
    const dy2 = prev.y - current.y;
    const len2 = Math.sqrt(dx2 * dx2 + dy2 * dy2);
    
    /* Normalized vectors */
    const nx1 = dx1 / len1;
    const ny1 = dy1 / len1;
    const nx2 = dx2 / len2;
    const ny2 = dy2 / len2;
    
    /* Points offset from the corner */
    const p1 = {
      x: current.x + nx2 * radiusValue,
      y: current.y + ny2 * radiusValue
    };
    
    const p2 = {
      x: current.x + nx1 * radiusValue,
      y: current.y + ny1 * radiusValue
    };
    
    /* Start with the first point */
    if (i === 0) {
      path += `M ${p1.x} ${p1.y} `;
    }
    
    /* Quadratic curve around the corner */
    path += `Q ${current.x} ${current.y} ${p2.x} ${p2.y} `;
    
    /* Line to the next corner's offset point */
    const nextCurrent = next;
    const nextNext = points[(i + 2) % points.length];
    const dx3 = nextNext.x - nextCurrent.x;
    const dy3 = nextNext.y - nextCurrent.y;
    const len3 = Math.sqrt(dx3 * dx3 + dy3 * dy3);
    const nx3 = dx3 / len3;
    const ny3 = dy3 / len3;
    
    const nextP1 = {
      x: nextCurrent.x - nx1 * radiusValue,
      y: nextCurrent.y - ny1 * radiusValue
    };
    
    path += `L ${nextP1.x} ${nextP1.y} `;
  }
  
  path += 'Z';
  
  return `path('${path}')`;
}

/* Function to create rhombus layout */
function initRhombusGallery(id, s = null, m = null, borderRadius = null) {
  /* Build selectors with the provided id */
  const gallerySelector = `${id} .pixgallery-rhombus`;
  const containerSelector = `${id} .pixgallery-rhombus-container`;
  const childSelector = `${id} .pixgallery-rhombus-child`;
  
  /* Get elements */
  const gallery = document.querySelector(gallerySelector);
  const container = document.querySelector(containerSelector);
  const children = document.querySelectorAll(childSelector);
  const outerEl = document.querySelector(id);
  
  if (!gallery || !container || children.length === 0) {
    console.error(`Gallery elements not found for id: ${id}`);
    return;
  }
  
  /* Function to normalize CSS values with default */
  function normalizeCSSValue(value, defaultValue) {
    if (value == null) return defaultValue;
    
    /* If it's a number, add 'px' */
    if (typeof value === 'number' && !isNaN(value)) {
      return `${value}px`;
    }
    
    /* If it's a string, validate it's a valid CSS length unit */
    if (typeof value === 'string') {
      const trimmed = value.trim();
      /* Check if it matches common CSS units */
      if (/^-?\d+\.?\d*(px|em|rem|vh|vw|%|pt|cm|mm|in|pc|ex|ch|vmin|vmax)$/.test(trimmed)) {
        return trimmed;
      }
      /* If it's just a number as string, add 'px' */
      const num = parseFloat(trimmed);
      if (!isNaN(num)) {
        return `${num}px`;
      }
    }
    
    return defaultValue;
  }
  
  /* Determine final values for s, m, and borderRadius with defaults */
  const finalS = normalizeCSSValue(s, '150px');
  const finalM = normalizeCSSValue(m, '4px');
  const finalBorderRadius = normalizeCSSValue(borderRadius, '0px');
  
  /* Parse numeric values for calculations (assume px if no unit for calculations) */
  const sNumeric = parseFloat(finalS);
  const mNumeric = parseFloat(finalM);
  const r = sNumeric + 4 * mNumeric - 2;

  /* Apply calculated styles to children */
  children.forEach(child => {
    /* Calculate and apply child dimensions and margins */
    child.style.width = finalS;
    child.style.height = finalS;
    child.style.margin = finalM;
    child.style.marginBottom = `calc(${finalM} - ${finalS} * 0.5)`;
    
    /* Apply clip-path for rhombus shape */
    child.style.clipPath = createRoundedRhombus(finalS, finalBorderRadius);
    /* child.style.clipPath = 'polygon(50% 0, 100% 50%, 50% 100%, 0 50%)'; */
    /* Apply clip-path for caption */
    const captionDiv = child.querySelector('.pixgallery-caption');
    if (captionDiv) {
      captionDiv.style.clipPath = createRoundedRhombus(finalS, finalBorderRadius);
    }
    
    /* Find the anchor element */
    const anchor = child.querySelector('a');
    if (anchor) {
      anchor.style.position = 'absolute';
      anchor.style.height = finalS;
      anchor.style.width = finalS;
      anchor.style.display = 'block';
      anchor.style.borderRadius = finalBorderRadius;
    }
  });
  
  /* Add clearfix element at the end of container */
  const clearfix = document.createElement('div');
  clearfix.style.clear = 'both';
  clearfix.style.height = '0';
  container.appendChild(clearfix);
  
  /* Apply container::before pseudo-element properties via a style element */
  const styleId = `rhombus-gallery-dynamic-styles-${id.replace(/[^a-zA-Z0-9]/g, '_')}`;
  let styleEl = document.getElementById(styleId);
  
  if (!styleEl) {
    styleEl = document.createElement('style');
    styleEl.id = styleId;
    document.head.appendChild(styleEl);
  }
  
  styleEl.textContent = `
    ${containerSelector} {
      overflow: hidden;
    }
    ${containerSelector}::before {
      content: "";
      width: calc(${finalS} / 2 + ${finalM});
      float: left;
      height: 140%;
      shape-outside: repeating-linear-gradient(
        #0000 0 ${r - 3}px,
        #000 0 ${r}px
      );
    }
    ${containerSelector}::after {
      content: "";
      display: table;
      clear: both;
    }
    ${id} {
      height: auto !important;
      overflow: visible !important;
    }
    ${gallerySelector} {
      overflow: visible;
    }
  `;
  
  /* Function to calculate and update height */
  function updateHeight() {
    /* Find the last child's position */
    const lastChild = children[children.length - 1];
    if (lastChild) {
      const lastRect = lastChild.getBoundingClientRect();
      const containerRect = container.getBoundingClientRect();
      
      /* The bottom of the last element relative to container top */
      /* Add back the negative margin since it's visually extending beyond */
      const actualBottom = lastRect.bottom - containerRect.top + (sNumeric * 0.5 - mNumeric);
      
      container.style.minHeight = `${actualBottom}px`;
      
      if (outerEl) {
        outerEl.style.setProperty('height', `${actualBottom + 20}px`, 'important');
        outerEl.style.setProperty('overflow', 'visible', 'important');
      }
    }
  }
  
  /* Initial height calculation */
  setTimeout(updateHeight, 100);
  
  /* Debounce function to limit resize calls */
  let resizeTimeout;
  function handleResize() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(updateHeight, 150);
  }
  
  /* Add resize event listener */
  window.addEventListener('resize', handleResize);
  
  /* Store cleanup function on the gallery element for potential cleanup later */
  gallery._rhombusCleanup = () => {
    window.removeEventListener('resize', handleResize);
  };
}

function pixgallery_rhombus(el,x){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var link = x.link;
  var h = x.h;
  var gap = x.gap;
  var borderRadius = x.border_radius;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-rhombus-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-rhombus-image" src="{src}"></a></div>';

  } else {

    if(captionValign == "none"){

      var temp = '<div class="pixgallery-child pixgallery-rhombus-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-rhombus-image" src="{src}"></a></div>';

    } else if(captionValign == "top") {

      var temp = '<div class="pixgallery-child pixgallery-rhombus-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-rhombus-image" src="{src}"><div class="pixgallery-rhombus-caption pixgallery-rhombus-caption-top" style="justify-content:{captionHalign};"><div class="pixgallery-rhombus-caption-inner">{caption}</div></div></a></div>';

    } else if(captionValign == "center") {

      var temp = '<div class="pixgallery-child pixgallery-rhombus-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-rhombus-image" src="{src}"><div class="pixgallery-rhombus-caption pixgallery-rhombus-caption-center" style="justify-content:{captionHalign};"><div class="pixgallery-rhombus-caption-inner">{caption}</div></div></a></div>';

    } else {

      var temp = '<div class="pixgallery-child pixgallery-rhombus-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-rhombus-image" src="{src}"><div class="pixgallery-rhombus-caption pixgallery-rhombus-caption-bottom" style="justify-content:{captionHalign};"><div class="pixgallery-rhombus-caption-inner">{caption}</div></div></a></div>';

    }
  }
  
  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{src\}/g, src[i]).replace(/\{captionHalign\}/g, captionHalign)

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

  document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-rhombus"><div class="pixgallery-rhombus-container">' + newValues + '</div></div>';
  
  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      initRhombusGallery('#' + el.id, h, gap, borderRadius);
    });
  } else {
    initRhombusGallery('#' + el.id, h, gap, borderRadius);
  }
}

/* hexagon ------------------------------------------------------------------ */
/* Function to create hexagon polygon with border radius */
function createRoundedHexagon(size, radius) {
  /* Parse size (assume pixels if no unit provided) */
  const sizeValue = typeof size === 'number' ? size : parseFloat(size);
  
  /* Parse radius and convert to pixels relative to size */
  let radiusValue;
  if (typeof radius === 'number') {
    radiusValue = radius;
  } else if (typeof radius === 'string') {
    const match = radius.match(/^([\d.]+)(.*)$/);
    if (match) {
      const value = parseFloat(match[1]);
      const unit = match[2] || 'px';
      
      /* Convert different units to pixels relative to size */
      switch(unit) {
        case 'px':
          radiusValue = value;
          break;
        case '%':
          radiusValue = (value / 100) * sizeValue;
          break;
        case 'em':
        case 'rem':
          radiusValue = value * 16;
          break;
        default:
          radiusValue = value;
      }
    }
  }
  
  const width = sizeValue;
  const height = sizeValue * 1.1547;
  const cx = width / 2;
  
  /* The 6 corner points of the hexagon */
  const points = [
    { x: cx, y: 0 },
    { x: width, y: height * 0.25 },
    { x: width, y: height * 0.75 },
    { x: cx, y: height },
    { x: 0, y: height * 0.75 },
    { x: 0, y: height * 0.25 }
  ];
  
  let path = '';
  
  for (let i = 0; i < points.length; i++) {
    const current = points[i];
    const next = points[(i + 1) % points.length];
    const prev = points[(i - 1 + points.length) % points.length];
    
    /* Vector from current to next */
    const dx1 = next.x - current.x;
    const dy1 = next.y - current.y;
    const len1 = Math.sqrt(dx1 * dx1 + dy1 * dy1);
    
    /* Vector from current to previous */
    const dx2 = prev.x - current.x;
    const dy2 = prev.y - current.y;
    const len2 = Math.sqrt(dx2 * dx2 + dy2 * dy2);
    
    /* Normalized vectors */
    const nx1 = dx1 / len1;
    const ny1 = dy1 / len1;
    const nx2 = dx2 / len2;
    const ny2 = dy2 / len2;
    
    /* Points offset from the corner */
    const p1 = {
      x: current.x + nx2 * radiusValue,
      y: current.y + ny2 * radiusValue
    };
    
    const p2 = {
      x: current.x + nx1 * radiusValue,
      y: current.y + ny1 * radiusValue
    };
    
    /* Start with the first point */
    if (i === 0) {
      path += `M ${p1.x} ${p1.y} `;
    }
    
    /* Quadratic curve around the corner */
    path += `Q ${current.x} ${current.y} ${p2.x} ${p2.y} `;
    
    /* Line to the next corner's offset point */
    const nextCurrent = next;
    const nextNext = points[(i + 2) % points.length];
    const dx3 = nextNext.x - nextCurrent.x;
    const dy3 = nextNext.y - nextCurrent.y;
    const len3 = Math.sqrt(dx3 * dx3 + dy3 * dy3);
    const nx3 = dx3 / len3;
    const ny3 = dy3 / len3;
    
    const nextP1 = {
      x: nextCurrent.x - nx1 * radiusValue,
      y: nextCurrent.y - ny1 * radiusValue
    };
    
    path += `L ${nextP1.x} ${nextP1.y} `;
  }
  
  path += 'Z';
  
  return `path('${path}')`;
}

/* Function to create hexagon layout */
function initHexagonGallery(id, s = null, m = null, borderRadius = null) {
  /* Build selectors with the provided id */
  const gallerySelector = `${id} .pixgallery-hexagon`;
  const containerSelector = `${id} .pixgallery-hexagon-container`;
  const childSelector = `${id} .pixgallery-hexagon-child`;
  
  /* Get elements */
  const gallery = document.querySelector(gallerySelector);
  const container = document.querySelector(containerSelector);
  const children = document.querySelectorAll(childSelector);
  const outerEl = document.querySelector(id);
  
  if (!gallery || !container || children.length === 0) {
    console.error(`Gallery elements not found for id: ${id}`);
    return;
  }
  
  /* Function to normalize CSS values */
  function normalizeCSSValue(value, defaultValue) {
    if (value == null) return defaultValue;
    
    /* If it's a number, add 'px' */
    if (typeof value === 'number' && !isNaN(value)) {
      return `${value}px`;
    }
    
    /* If it's a string, validate it's a valid CSS length */
    if (typeof value === 'string') {
      const trimmed = value.trim();
      /* Check if it matches common CSS units */
      if (/^-?\d+\.?\d*(px|em|rem|vh|vw|%|pt|cm|mm|in|pc|ex|ch|vmin|vmax)$/.test(trimmed)) {
        return trimmed;
      }
      /* If it's just a number as string, add 'px' */
      const num = parseFloat(trimmed);
      if (!isNaN(num)) {
        return `${num}px`;
      }
    }
    
    return defaultValue;
  }
  
  /* Determine final values for s, m, and borderRadius with defaults */
  const finalS = normalizeCSSValue(s, '150px');
  const finalM = normalizeCSSValue(m, '4px');
  const finalBorderRadius = normalizeCSSValue(borderRadius, '0px');
  
  /* Parse numeric values for calculations (assume px if no unit for calculations) */
  const sNumeric = parseFloat(finalS);
  const mNumeric = parseFloat(finalM);
  const f = 1.732 * sNumeric + 4 * mNumeric - 1;

  /* Apply calculated styles to children */
  children.forEach(child => {
    /* Calculate and apply child dimensions */
    child.style.width = finalS;
    child.style.height = `calc(${finalS} * 1.1547)`;
    child.style.margin = finalM;
    child.style.marginBottom = `calc(${finalM} - ${finalS} * 0.2885)`;
    
    /* Apply clip-path for hexagon shape */
    if (borderRadius && parseFloat(finalBorderRadius) > 0) {
      child.style.clipPath = createRoundedHexagon(finalS, finalBorderRadius);
    } else {
      child.style.clipPath = 'polygon(0% 25%, 0% 75%, 50% 100%, 100% 75%, 100% 25%, 50% 0%)';
    }
    
    /* Apply clip-path for caption */
    const captionDiv = child.querySelector('.pixgallery-caption');
    if (captionDiv) {
      if (borderRadius && parseFloat(finalBorderRadius) > 0) {
        captionDiv.style.clipPath = createRoundedHexagon(finalS, finalBorderRadius);
      } else {
        captionDiv.style.clipPath = 'polygon(0% 25%, 0% 75%, 50% 100%, 100% 75%, 100% 25%, 50% 0%)';
      }
    }
    
    /* Find the anchor element */
    const anchor = child.querySelector('a');
    if (anchor) {
      anchor.style.position = 'absolute';
      anchor.style.height = `calc(${finalS} * 1.1547)`;
      anchor.style.width = finalS;
      anchor.style.display = 'block';
      anchor.style.borderRadius = finalBorderRadius;
    }
  });
  
  /* Add clearfix element at the end of container */
  const clearfix = document.createElement('div');
  clearfix.style.clear = 'both';
  clearfix.style.height = '0';
  container.appendChild(clearfix);
  
  /* Apply container::before pseudo-element properties via a style element */
  const styleId = `hexagon-gallery-dynamic-styles-${id.replace(/[^a-zA-Z0-9]/g, '_')}`;
  let styleEl = document.getElementById(styleId);
  
  if (!styleEl) {
    styleEl = document.createElement('style');
    styleEl.id = styleId;
    document.head.appendChild(styleEl);
  }
  
  styleEl.textContent = `
    ${containerSelector} {
      overflow: hidden;
      font-size: 0;
    }
    ${childSelector} {
      display: inline-block;
      font-size: initial;
    }
    ${containerSelector}::before {
      content: "";
      width: calc(${finalS} / 2 + ${finalM});
      float: left;
      height: 120%;
      shape-outside: repeating-linear-gradient(
        #0000 0 calc(${f}px - 3px),
        #000 0 ${f}px
      );
    }
    ${containerSelector}::after {
      content: "";
      display: table;
      clear: both;
    }
    ${id} {
      height: auto !important;
      overflow: visible !important;
    }
    ${gallerySelector} {
      overflow: visible;
      display: flex;
    }
  `;
  
  /* Function to calculate and update height */
  function updateHeight() {
    /* Find the last child's position */
    const lastChild = children[children.length - 1];
    if (lastChild) {
      const lastRect = lastChild.getBoundingClientRect();
      const containerRect = container.getBoundingClientRect();
      
      /* The bottom of the last element relative to container top */
      /* Add back the negative margin since it's visually extending beyond */
      const actualBottom = lastRect.bottom - containerRect.top + (sNumeric * 0.2885 - mNumeric);
      
      container.style.minHeight = `${actualBottom}px`;
      
      if (outerEl) {
        outerEl.style.setProperty('height', `${actualBottom + 20}px`, 'important');
        outerEl.style.setProperty('overflow', 'visible', 'important');
      }
    }
  }
  
  /* Initial height calculation */
  setTimeout(updateHeight, 100);
  
  /* Debounce function to limit resize calls */
  let resizeTimeout;
  function handleResize() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(updateHeight, 150);
  }
  
  /* Add resize event listener */
  window.addEventListener('resize', handleResize);
  
  /* Store cleanup function on the gallery element for potential cleanup later */
  gallery._hexagonCleanup = () => {
    window.removeEventListener('resize', handleResize);
  };
}

function pixgallery_hexagon(el,x){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var link = x.link;
  var h = x.h;
  var gap = x.gap;
  var borderRadius = x.border_radius;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-hexagon-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-hexagon-image" src="{src}"></a></div>';

  } else {

    if(captionValign == "none"){

      var temp = '<div class="pixgallery-child pixgallery-hexagon-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-hexagon-image" src="{src}"></a></div>';

    } else if(captionValign == "top") {

      var temp = '<div class="pixgallery-child pixgallery-hexagon-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-hexagon-image" src="{src}"><div class="pixgallery-hexagon-caption pixgallery-hexagon-caption-top" style="justify-content:{captionHalign};"><div class="pixgallery-hexagon-caption-inner">{caption}</div></div></a></div>';

    } else if(captionValign == "center") {

      var temp = '<div class="pixgallery-child pixgallery-hexagon-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-hexagon-image" src="{src}"><div class="pixgallery-hexagon-caption pixgallery-hexagon-caption-center" style="justify-content:{captionHalign};"><div class="pixgallery-hexagon-caption-inner">{caption}</div></div></a></div>';

    } else {

      var temp = '<div class="pixgallery-child pixgallery-hexagon-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-hexagon-image" src="{src}"><div class="pixgallery-hexagon-caption pixgallery-hexagon-caption-bottom" style="justify-content:{captionHalign};"><div class="pixgallery-hexagon-caption-inner">{caption}</div></div></a></div>';

    }
  }
  
  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{src\}/g, src[i]).replace(/\{captionHalign\}/g, captionHalign)

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

  document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-hexagon"><div class="pixgallery-hexagon-container">' + newValues + '</div></div>';
  
  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      initHexagonGallery('#' + el.id, h, gap, borderRadius);
    });
  } else {
    initHexagonGallery('#' + el.id, h, gap, borderRadius);
  }
}

/* scroll ------------------------------------------------------------------- */

function pixgallery_scroll(el,x,fixed){

  var urls = x.path;
  var src = x.path;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var h = x.h;
  var w = x.w;
  var gap = x.gap;
  var borderRadius = x.border_radius;

  if(typeof link[0] !== 'boolean') urls = link
  if(h === null) h = "200px";
  if(w === null) w = "200px";

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div class="pixgallery-child pixgallery-scroll-child" id="pixgallery-{id}"><a href="{url}" class="glightbox" data-gallery="{id}"><img class="pixgallery-scroll-image" style="border-radius:{borderRadius};height:{h};width:{w};" src="{src}"></a></div>';

  } else {
    if(captionValign == "none"){

      /* If captions are not displayed */
      var temp = '<div class="pixgallery-child pixgallery-scroll-child" id="pixgallery-{id}" style="height:{h};width:{w};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-scroll-image" style="border-radius:{borderRadius};height:{h};width:{w};" src="{src}"></a></div>';

    } else if(captionValign == "below") {

      var temp = '<div class="pixgallery-child pixgallery-scroll-child pixgallery-scroll-child-below" id="pixgallery-{id}" style="grid-template-rows:{h} 1fr;width:{w};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-scroll-image pixgallery-scroll-image-below" style="border-radius:{borderRadius} {borderRadius} 0 0;" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-below" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};">{caption}</div></div>';
      
    } else if(captionValign == "top") {

      var temp = '<div class="pixgallery-child pixgallery-scroll-child pixgallery-child-over" id="pixgallery-{id}" style="height:{h};width:{w};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-scroll-image pixgallery-scroll-image-over" style="border-radius:{borderRadius};height:{h};width:{w};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-top" style="border-radius:{borderRadius};text-align:{captionHalign};height:{h};">{caption}</div></div>';
      
    } else if(captionValign == "center") {

      var temp = '<div class="pixgallery-child pixgallery-scroll-child pixgallery-child-over" id="pixgallery-{id}" style="height:{h};width:{w};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-scroll-image pixgallery-scroll-image-over" style="border-radius:{borderRadius};height:{h};width:{w};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-center" style="border-radius:{borderRadius};text-align:{captionHalign};height:{h};">{caption}</div></div>';

    } else {

      var temp = '<div class="pixgallery-child pixgallery-scroll-child pixgallery-child-over" id="pixgallery-{id}" style="height:{h};width:{w};"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption}"><img class="pixgallery-scroll-image pixgallery-scroll-image-over" style="border-radius:{borderRadius};height:{h};width:{w};" src="{src}"></a><div class="pixgallery-caption pixgallery-caption-bottom" style="border-radius:0 0 {borderRadius} {borderRadius};text-align:{captionHalign};height:{h};">{caption}</div></div>';
    }
  }

  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{h\}/g, h).replace(/\{w\}/g, w).replace(/\{borderRadius\}/g, borderRadius).replace(/\{src\}/g, src[i]).replace(/\{min-height\}/g, h)

    /* Link based fix */
    if(typeof link[0] !== 'boolean'){
      newValue = newValue.replace("class=\"glightbox\"","target=\"_blank\"")
    } else if (typeof(link[0]) == 'boolean' && link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("class=\"glightbox\"","")
    }

    /* If caption is not empty */
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i]).replace(/\{captionHalign\}/g, captionHalign)
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
  }

  if(captionValign == "none") {
    document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-scroll" style="gap:' + gap + ';">' + newValues + '</div>';
  } else if(captionValign == "below") {
    document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-scroll" style="gap:' + gap + ';">' + newValues + '</div>';
  } else {
    document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-scroll" style="gap:' + gap + ';">' + newValues + '</div>';
  }

  if(link[0] === true) {
    var lightbox_options = Object.assign(x.lightbox || {});
    var lightbox = GLightbox(lightbox_options);
  }
}
