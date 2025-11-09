HTMLWidgets.widget({

  name: 'pixcarousel',
  type: 'output',

  factory: function(el, width, height) {

    /* TODO: define shared variables for this instance */

    return {
      renderValue: function(opts) {
        pixcarousel(el,opts);
      },
      resize: function(width, height) {
        /* TODO: code to re-render the widget with a new size */
      }
    };
  }
});

function shuffle(path, caption, link, caption_lightbox) {
  var index = path.length;
  var rnd, tmp1, tmp2, tmp3, tmp4;
  
  // Determine which arrays need shuffling
  var shuffleCaption = caption !== null && caption.length === path.length;
  var shuffleLink = link !== null && link.length === path.length;
  var shuffleCaptionLightbox = caption_lightbox !== null && caption_lightbox.length === path.length;

  while (index) {
    rnd = Math.floor(Math.random() * index);
    index -= 1;
    
    // Always shuffle path
    tmp1 = path[index];
    path[index] = path[rnd];
    path[rnd] = tmp1;
    
    // Shuffle caption if it's an array of same length
    if (shuffleCaption) {
      tmp2 = caption[index];
      caption[index] = caption[rnd];
      caption[rnd] = tmp2;
    }
    
    // Shuffle link if it's an array of same length
    if (shuffleLink) {
      tmp3 = link[index];
      link[index] = link[rnd];
      link[rnd] = tmp3;
    }
    
    // Shuffle caption_lightbox if it's an array of same length
    if (shuffleCaptionLightbox) {
      tmp4 = caption_lightbox[index];
      caption_lightbox[index] = caption_lightbox[rnd];
      caption_lightbox[rnd] = tmp4;
    }
  }
}

/* pixcarousel -------------------------------------------------------------- */

function pixcarousel(el,x){

  if(x.shuffle) shuffle(x.path, x.caption, x.link, x.caption_lightbox);
  var urls = x.path;
  var src = x.path;
  var h = x.h;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var captionLightbox = x.caption_lightbox;
  var gap = x.gap;
  var borderRadius = x.border_radius;
  var fit = x.fit;
  var position = x.position;

  if(typeof link[0] !== 'boolean') urls = link
  if(typeof captionLightbox[0] === 'boolean') {
    if(captionLightbox[0] === true) {
      var caption2 = caption;
    } else {
      var caption2 = new Array(1).fill("");
    }
  } else {
    caption2 = captionLightbox;
  }

  var buttonLeft = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 477.175 477.175" xml:space="preserve"><defs><filter id="thicken"><feMorphology operator="dilate" radius="0.5"/></filter></defs><g filter="url(#thicken)"><path d="M145.188,238.575l215.5-215.5c5.3-5.3,5.3-13.8,0-19.1s-13.8-5.3-19.1,0l-225.1,225.1c-5.3,5.3-5.3,13.8,0,19.1l225.1,225c2.6,2.6,6.1,4,9.5,4s6.9-1.3,9.5-4c5.3-5.3,5.3-13.8,0-19.1L145.188,238.575z"></path></g></svg>';
  var buttonRight = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 477.175 477.175" xml:space="preserve"><defs><filter id="thicken2"><feMorphology operator="dilate" radius="0.5"/></filter></defs><g filter="url(#thicken2)"><path d="M360.731,229.075l-225.1-225.1c-5.3-5.3-13.8-5.3-19.1,0s-5.3,13.8,0,19.1l215.5,215.5l-215.5,215.5c-5.3,5.3-5.3,13.8,0,19.1c2.6,2.6,6.1,4,9.5,4c3.4,0,6.9-1.3,9.5-4l225.1-225.1C365.931,242.875,365.931,234.275,360.731,229.075z"></path></g></svg>';

  /* Initialize template */
  if(caption.length === 0){

    /* If captions are not used */
    var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption2}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};padding-left:{gap};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a></div>';

  } else {
    if(captionValign == "none"){

      /* If captions are not displayed */
      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption2}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};padding-left:{gap};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a></div>';

    } else if(captionValign == "top") {

      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child pixcarousel-child-over"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption2}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};padding-left:{gap};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a><div class="pixcarousel-caption pixcarousel-caption-top" style="text-align:{captionHalign};margin-right:{gap};margin-left:{gap};">{caption}</div></div>';
      
    } else if(captionValign == "center") {

      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child pixcarousel-child-over"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption2}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};padding-left:{gap};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a><div class="pixcarousel-caption pixcarousel-caption-center" style="text-align:{captionHalign};margin-right:{gap};margin-left:{gap};">{caption}</div></div>';

    } else if(captionValign == "bottom") {

      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child pixcarousel-child-over"><a href="{url}" class="glightbox" data-gallery="{id}" data-description="{caption2}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};padding-left:{gap};object-fit:{fit};-o-object-fit:{fit};object-position:{position};" src="{src}"></a><div class="pixcarousel-caption pixcarousel-caption-bottom" style="text-align:{captionHalign};margin-right:{gap};margin-left:{gap};">{caption}</div></div>';
    }
  }

  var newValues = '', limitItem = src.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace(/\{id\}/g, el.id).replace(/\{src\}/g, src[i]).replace(/\{h\}/g, h).replace(/\{gap\}/g, gap).replace(/\{fit\}/g, fit).replace(/\{position\}/g, position);

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

    /* If caption2 is not empty */
    if(caption2.length !== 0){
      if(caption2[i] === null || caption2[i] === undefined) caption2[i] = "";
      newValue = newValue.replace(/\{caption2\}/g, caption2[i])
    } else {
      newValue = newValue.replace("data\-description\=\"\{caption2\}\"", "")
    }

    newValues += newValue.replace(/\{url\}/g, urls[i])
  }

  temp = '';
  temp = temp + '<div class="pixcarousel glider-contain"><div id="pixcarousel-{id}" class="glider" style="border-radius:' + borderRadius + ';">' + newValues + '</div>' + '<div class="pixcarousel-controls">' + '<button aria-label="Previous" id="pixcarousel-{id}-glider-prev" class="glider-prev">' + buttonLeft + '</button>' + '<div role="tablist" id="pixcarousel-{id}-dots" class="dots"></div>' + '<button aria-label="Next"  id="pixcarousel-{id}-glider-next" class="glider-next">' + buttonRight + '</button>' + '</div></div>';

  document.getElementById(el.id).innerHTML = temp.replace(/\{id\}/g,el.id);

  var carousel_default = {
    dots: '#pixcarousel-' + el.id + '-dots',
    arrows: {
      prev: '#pixcarousel-' + el.id + '-glider-prev',
      next: '#pixcarousel-' + el.id + '-glider-next'
    }
  }
  var carousel_options = Object.assign({}, x.carousel, carousel_default);
  new Glider(document.querySelector('#pixcarousel-' + el.id + '.glider'), carousel_options);

  if(link[0] === true) {
    const lightbox_options = Object.assign(x.lightbox || {});
    const lightbox = GLightbox(lightbox_options);
  }
}
