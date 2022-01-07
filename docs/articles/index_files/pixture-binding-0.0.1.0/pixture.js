HTMLWidgets.widget({

  name: 'pixture',
  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {
      renderValue: function(opts) {
        pixture_basic(el,opts);
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});

function pixture_basic(el,x){

  let urls = x.path;
  let caption = x.caption;
  let w = x.w;
  let h = x.h;
  let gap = x.gap;

  let temp = '<div class="pixture-child" id="pixture-{id}"><a href="{index}" title="{caption}"><div class="pixture-image" style="height:{height}; width:{width}; background-image:url(\'{index}\')"></div></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {

    if(caption === null) {
     newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      if(caption[i] === null) {
        newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
      } else {
        newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
      }
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixture-gallery" style="gap:' + gap + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixture-' + el.id + ' a'});
}
