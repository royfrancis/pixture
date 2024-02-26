HTMLWidgets.widget({

  name: 'pixgallery',
  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {
      renderValue: function(opts) {
        pixgallery_base(el,opts);
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

function pixgallery_base(el,x){
  if(x.shuffle) shuffle(x.path, x.caption);
  if(x.layout === "grid") pixgallery_grid(el,x);
  if(x.layout === "gridfixed") pixgallery_gridfixed(el,x);
  if(x.layout === "masonry") pixgallery_masonry(el,x);
  if(x.layout === "justified") pixgallery_justified(el,x);
  if(x.layout === "elastic") pixgallery_elastic(el,x);
  if(x.layout === "rhombus") pixgallery_rhombus(el,x);
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_grid(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;
  let borderRadius = x.border_radius;

  let temp = '<div class="pixgallery-child pixgallery-child-grid" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-grid" style="border-radius:{borderRadius};height:{dim};" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-gallery-grid" style="gap:' + gap + ';grid-template-columns: repeat(auto-fit, minmax(' + dim + ',1fr));grid-auto-rows:' + dim + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_gridfixed(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;
  let borderRadius = x.border_radius;

  let temp = '<div class="pixgallery-child pixgallery-child-gridfixed" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-gridfixed" style="border-radius:{borderRadius};height:{dim};" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-gallery-gridfixed" style="gap:' + gap + ';gridfixed-template-columns: repeat(auto-fit, ' + dim + ');gridfixed-auto-rows:' + dim + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_rhombus(el,x){

  let urls = x.path;
  let caption = x.caption;
  let gap = x.gap;

  let temp = '<div class="pixgallery-child pixgallery-child-rhombus" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-rhombus" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

  document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-gallery-rhombus" style="gap:' + gap + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_elastic(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;

  let temp = '<div class="pixgallery-child pixgallery-child-elastic" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-elastic" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{url\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-gallery-elastic" style="height:' + dim + ';gap:' + gap + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_masonry(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;
  let borderRadius = x.border_radius;

  let temp = '<div class="pixgallery-child pixgallery-child-masonry" id="pixgallery-{id}" style="margin-bottom:{gap};"><a href="{url}" title="{caption}"><img class="pixgallery-image-masonry" style="border-radius:{borderRadius};" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{gap\}/g, gap).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{gap\}/g, gap).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-gallery-masonry" style="column-gap:' + gap + ';column-width:' + dim + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}

/* flex grid parent and children divs have images as img -------------------- */
function pixgallery_justified(el,x){

  let urls = x.path;
  let caption = x.caption;
  let dim = x.dim;
  let gap = x.gap;
  let borderRadius = x.border_radius;

  let temp = '<div class="pixgallery-child pixgallery-child-justified" id="pixgallery-{id}"><a href="{url}" title="{caption}"><img class="pixgallery-image-justified" style="height:{dim};border-radius:{borderRadius};" src="{url}"></a></div>';

	let newValues = '', limitItem = urls.length;
	for (let i = 0; i < limitItem; ++i) {
    if(caption == null || caption[i] == null) {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{gap\}/g, gap).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("title=\"{caption}\"","");
    } else {
      newValues += temp.replace(/\{dim\}/g, dim).replace(/\{gap\}/g, gap).replace(/\{url\}/g, urls[i]).replace(/\{borderRadius\}/g, borderRadius).replace("{id}",el.id).replace("{caption}",caption[i]);
    }
	}

	document.getElementById(el.id).innerHTML = '<div class="pixgallery-gallery pixgallery-gallery-justified" style="column-gap:' + gap + ';">' + newValues + '</div>';
  var lightbox = new SimpleLightbox({elements: '#pixgallery-' + el.id + ' a'});
}
