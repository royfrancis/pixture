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
  let draggable = x.options.draggable;
	let animate = x.options.animate;
  let cellW = x.options.cellW;
  let cellH = x.options.cellH;
  let delay = x.options.delay;
  let fixSize = x.options.fixSize;
  let gutterX = x.options.gutterX;
  let gutterY = x.options.gutterY;
  let selector = x.options.selector;
	let cacheSize = x.options.cacheSize;
	let keepOrder = x.options.keepOrder;
	let rightToLeft = x.options.rightToLeft;
	let bottomToTop = x.options.bottomToTop;

  if (x.preset === "grid") {

    let temp = "<a href={index} data-lightbox={id} data-title={caption}><div class='fw-cell' style='width:{width}px; height: {height}px; background-image: url({index})'></div></a>";
			let w = cellW, h = cellH, newValues = '', limitItem = urls.length;

			for (let i = 0; i < limitItem; ++i) {

        if(caption === null) {
          newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("data-title={caption}","");
        } else {
          if(caption[i] === null) {
            newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("data-title={caption}","");
          } else {
            newValues += temp.replace(/\{height\}/g, h).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
          }
        }
			}
			$(el).html(newValues);

			let wall = new Freewall(el);
			wall.reset({
				draggable: draggable,
				animate: animate,
				cellW: cellW,
				cellH: cellH,
				delay: delay,
				fixSize: fixSize,
				gutterX: gutterX,
        gutterY: gutterY,
				selector: selector,
				cacheSize: cacheSize,
				keepOrder: keepOrder,
				rightToLeft: rightToLeft,
				bottomToTop: bottomToTop,
				onResize: function() {
					wall.refresh();
				}
			});
			wall.fitWidth();

			// for scroll bar appear;
			$(window).trigger("resize");

  } else if (x.preset === "mixedwidth"){

    let temp = "<a href={index} data-lightbox={id} data-title={caption}><div class='fw-cell' style='width:{width}px; height: {height}px; background-image: url({index})'></div></a>";

    let w = 1, newValues = '', limitItem = urls.length;
    for (let i = 0; i < limitItem; ++i) {
       w = 200 + 200 * Math.random() << 0;

       if(caption === null) {
         newValues += temp.replace(/\{height\}/g, 200).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("data-title={caption}","");
       } else {
         if(caption[i] === null) {
           newValues += temp.replace(/\{height\}/g, 200).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("data-title={caption}","");
         } else {
           newValues += temp.replace(/\{height\}/g, 200).replace(/\{width\}/g, w).replace(/\{index\}/g, urls[i]).replace("{id}",el.id).replace("{caption}",caption[i]);
         }
       }

   }
   $(el).html(newValues);

   let wall = new Freewall(el);
   wall.reset({
       draggable: draggable,
				animate: animate,
				cellW: cellW,
				cellH: cellH,
				delay: delay,
				fixSize: fixSize,
				gutterX: gutterX,
        gutterY: gutterY,
				selector: selector,
				cacheSize: cacheSize,
				keepOrder: keepOrder,
				rightToLeft: rightToLeft,
				bottomToTop: bottomToTop,
       onResize: function() {
           wall.fitWidth();
       }
   });
   wall.fitWidth();
  $(window).trigger("resize");

  } else if (x.preset === "fitzone") {

    let temp = "<div class='fw-brick' style='width:{width}px; height: {height}px; background-image: url({index})'></div>";
    let w = 1, h = 1, newValues = '', limitItem = urls.length;
			for (let i = 0; i < limitItem; ++i) {
				h = 1 + 3 * Math.random() << 0;
				w = 1 + 3 * Math.random() << 0;
				newValues += temp.replace(/\{height\}/g, h*cellH).replace(/\{width\}/g, w*cellW).replace("{index}", urls[i]);
			}
			$(el).html(newValues);


				let wall = new Freewall(el);
				wall.reset({
					draggable: draggable,
  				animate: animate,
  				cellW: cellW,
  				cellH: cellH,
  				delay: delay,
  				fixSize: fixSize,
  				gutterX: gutterX,
          gutterY: gutterY,
  				selector: '.fw-brick',
  				cacheSize: cacheSize,
  				keepOrder: keepOrder,
  				rightToLeft: rightToLeft,
  				bottomToTop: bottomToTop,
					onResize: function() {
						wall.refresh($(window).width() - 30, $(window).height() - 30);
					}
				});

				wall.fitZone($(window).width() - 30 , $(window).height() - 30);
        $(window).trigger("resize");

  } else {

    console.log("Incorrect choice of preset.");

  }
}
