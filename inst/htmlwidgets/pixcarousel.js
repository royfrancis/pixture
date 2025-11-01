HTMLWidgets.widget({

  name: 'pixcarousel',
  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {
      renderValue: function(opts) {
        pixcarousel(el,opts);
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
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

/* pixcarousel -------------------------------------------------------------- */

function pixcarousel(el,x){

  if(x.shuffle) shuffle(x.path, x.caption);
  var urls = x.path;
  var src = x.path;
  var h = x.h;
  var caption = x.caption;
  var captionValign = x.caption_valign;
  var captionHalign = x.caption_halign;
  var link = x.link;
  var gap = x.gap;
  var borderRadius = x.border_radius;
  var draggable = x.draggable;
  var slidesToShow = x.slides_to_show;
  var slidesToScroll = x.slides_to_scroll;
  var scrollLock = x.scroll_lock;
  var rewind = x.rewind;
  var showButtons = x.show_buttons;
  var showDots = x.show_dots;

  if(typeof link[0] !== 'boolean') urls = x.link
  var buttonLeft = '<svg height="40" viewBox="0 0 1792 1792" width="40" xmlns="http://www.w3.org/2000/svg"><path d="M1037 1395l102-102q19-19 19-45t-19-45l-307-307 307-307q19-19 19-45t-19-45l-102-102q-19-19-45-19t-45 19l-454 454q-19 19-19 45t19 45l454 454q19 19 45 19t45-19zm627-499q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>';
  var buttonRight = '<svg height="40" viewBox="0 0 1792 1792" width="40" xmlns="http://www.w3.org/2000/svg"><path d="M845 1395l454-454q19-19 19-45t-19-45l-454-454q-19-19-45-19t-45 19l-102 102q-19 19-19 45t19 45l307 307-307 307q-19 19-19 45t19 45l102 102q19 19 45 19t45-19zm819-499q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>'

  // initialize template
  if(caption.length === 0){

    // if captions are not used
    var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child"><a href="{url}" style="height:{h};"><img style="height:{h};padding-right:{gap};" class="pixcarousel-image" src="{src}"></a></div>';

  } else {
    if(captionValign == "none"){

      // if captions are not displayed
      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child"><a href="{url}" title="{caption}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};" src="{src}"></a></div>';

    } else if(captionValign == "top") {

      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child pixcarousel-child-over"><a href="{url}" title="{caption}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};" src="{src}"></a><div class="pixcarousel-caption pixcarousel-caption-top" style="text-align:{captionHalign};">{caption}</div></div>';
      
    } else if(captionValign == "center") {

      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child pixcarousel-child-over"><a href="{url}" title="{caption}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};" src="{src}"></a><div class="pixcarousel-caption pixcarousel-caption-center" style="text-align:{captionHalign};">{caption}</div></div>';

    } else if(captionValign == "bottom") {

      var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child pixcarousel-child-over"><a href="{url}" title="{caption}"><img class="pixcarousel-image" style="height:{h};padding-right:{gap};" src="{src}"></a><div class="pixcarousel-caption pixcarousel-caption-bottom" style="text-align:{captionHalign};">{caption}</div></div>';
    }
  }

  var newValues = '', limitItem = urls.length;
  for (let i = 0; i < limitItem; ++i) {

    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{src\}/g, src[i]).replace(/\{h\}/g, h).replace(/\{gap\}/g, gap)

    // if link is false or url is null, disable link
    if(urls[i]== null || link[0] === false){
      newValue = newValue.replace('href="{url}"', 'class="disabled"').replace("title=\"{caption}\"","")
    } else {
      newValue = newValue.replace(/\{url\}/g, urls[i])
    }

    // if caption is not empty
    if(caption.length !== 0){
      if(caption[i] === null || caption[i] === undefined) caption[i] = "";
      newValue = newValue.replace(/\{caption\}/g, caption[i]).replace(/\{captionHalign\}/g, captionHalign)
    }

    newValues += newValue
  }

  temp = '';
  temp = temp + '<div class="pixcarousel glider-contain"><div id="pixcarousel-{id}" class="glider" style="border-radius:' + borderRadius + ';">' + newValues + '</div>';
  if(showButtons) temp = temp + '<button aria-label="Previous" id="pixcarousel-{id}-glider-prev" class="glider-prev">' + buttonLeft + '</button>' + '<button aria-label="Next"  id="pixcarousel-{id}-glider-next" class="glider-next">' + buttonRight + '</button>';
  if(showDots) temp = temp + '<div role="tablist" id="pixcarousel-{id}-dots" class="dots"></div>';
  temp = temp + '</div>';

  document.getElementById(el.id).innerHTML = temp.replace(/\{id\}/g,el.id);

  new Glider(document.querySelector('#pixcarousel-' + el.id + '.glider'), {
    slidesToShow: slidesToShow,
    slidesToScroll: slidesToScroll,
    draggable: draggable,
    scrollLock: scrollLock,
    rewind: rewind,
    dots: '#pixcarousel-' + el.id + '-dots',
    arrows: {
      prev: '#pixcarousel-' + el.id + '-glider-prev',
      next: '#pixcarousel-' + el.id + '-glider-next'
    }
  })

  if(link[0] === true) var lightbox = new SimpleLightbox({elements: '#pixcarousel-' + el.id + '-child a'});
}
