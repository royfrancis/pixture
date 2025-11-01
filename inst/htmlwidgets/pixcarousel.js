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

/* pixcarousel -------------------------------------------------------------- */

function pixcarousel(el,x){

  var url = x.path;
  var src = x.path;
  var h = x.h;
  var draggable = x.draggable;
  var slidesToShow = x.slides_to_show;
  var slidesToScroll = x.slides_to_scroll;
  var scrollLock = x.scroll_lock;
  var rewind = x.rewind;
  var showButtons = x.show_buttons;
  var showDots = x.show_dots;

  /*if(h === null) h = '400px';*/
  var buttonLeft = '<svg height="40" viewBox="0 0 1792 1792" width="40" xmlns="http://www.w3.org/2000/svg"><path d="M1037 1395l102-102q19-19 19-45t-19-45l-307-307 307-307q19-19 19-45t-19-45l-102-102q-19-19-45-19t-45 19l-454 454q-19 19-19 45t19 45l454 454q19 19 45 19t45-19zm627-499q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>';
  var buttonRight = '<svg height="40" viewBox="0 0 1792 1792" width="40" xmlns="http://www.w3.org/2000/svg"><path d="M845 1395l454-454q19-19 19-45t-19-45l-454-454q-19-19-45-19t-45 19l-102 102q-19 19-19 45t19 45l307 307-307 307q-19 19-19 45t19 45l102 102q19 19 45 19t45-19zm819-499q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>'

  var temp = '<div id="pixcarousel-{id}-child" class="pixcarousel-child"><a href="{url}" style="height:{h};"><img style="height:{h};" class="pixcarousel-image" src="{src}"></a></div>';

  var newValues = '', limitItem = url.length;
  for (let i = 0; i < limitItem; ++i) {
    let newValue = '';
    newValue = temp.replace("{id}",el.id).replace(/\{src\}/g, src[i]).replace(/\{url\}/g, url[i]).replace(/\{h\}/g, h)
    newValues += newValue
  }

  temp = '';
  temp = temp + '<div class="pixcarousel glider-contain"><div id="pixcarousel-{id}-glider" class="glider">' + newValues + '</div>';
  if(showButtons) temp = temp + '<button aria-label="Previous" id="pixcarousel-{id}-glider-prev" class="glider-prev">' + buttonLeft + '</button>' + '<button aria-label="Next"  id="pixcarousel-{id}-glider-next" class="glider-next">' + buttonRight + '</button>';
  if(showDots) temp = temp + '<div role="tablist" id="pixcarousel-{id}-dots" class="dots"></div>';
  temp = temp + '</div>';

  document.getElementById(el.id).innerHTML = temp.replace(/\{id\}/g,el.id);

  new Glider(document.querySelector('#pixcarousel-' + el.id + '-glider'), {
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
}
