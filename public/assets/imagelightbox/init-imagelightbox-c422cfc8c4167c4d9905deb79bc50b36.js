$(function(){var i=function(){$('<div id="imagelightbox-loading"><div></div></div>').appendTo("body")},o=function(){$("#imagelightbox-loading").remove()},n=function(){$('<div id="imagelightbox-overlay"></div>').appendTo("body")},t=function(){$("#imagelightbox-overlay").remove()},e=function(i){$('<a href="#" id="imagelightbox-close">Close</a>').appendTo("body").on("click touchend",function(){return $(this).remove(),i.quitImageLightbox(),!1})},a=function(){$("#imagelightbox-close").remove()},d=function(){var i=$('a[href="'+$("#imagelightbox").attr("src")+'"] img').attr("alt");i.length>0&&$('<div id="imagelightbox-caption">'+i+"</div>").appendTo("body")},g=function(){$("#imagelightbox-caption").remove()},c=".stories a",l=$(c).imageLightbox({quitOnDocClick:!1,onStart:function(){n(),e(l)},onEnd:function(){a(),g(),t(),o()},onLoadStart:function(){g(),i()},onLoadEnd:function(){d(),o()}})});