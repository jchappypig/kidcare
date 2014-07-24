$(function() {
  var activityIndicatorOn = function() {
      $('<div id="imagelightbox-loading"><div></div></div>').appendTo('body');
    },
    activityIndicatorOff = function() {
      $('#imagelightbox-loading').remove();
    },

    overlayOn = function() {
      $('<div id="imagelightbox-overlay"></div>').appendTo('body');
    },
    overlayOff = function() {
      $('#imagelightbox-overlay').remove();
    },

    closeButtonOn = function(instance) {
      $('<a href="#" id="imagelightbox-close">Close</a>').appendTo('body').on('click touchend', function() {
        $(this).remove();
        instance.quitImageLightbox();
        return false;
      });
    },
    closeButtonOff = function() {
      $('#imagelightbox-close').remove();
    },

    captionOn = function() {
      var description = $('a[href="' + $('#imagelightbox').attr('src') + '"] img').attr('alt');
      if (description.length > 0)
        $('<div id="imagelightbox-caption">' + description + '</div>').appendTo('body');
    },
    captionOff = function() {
      $('#imagelightbox-caption').remove();
    };

  //	WITH ACTIVITY INDICATION

  var selectorA = '.stories a';
  var instanceA = $(selectorA).imageLightbox(
    {
      quitOnDocClick: false,
      onStart: function() {
        overlayOn();
        closeButtonOn(instanceA);
      },
      onEnd: function() {
        closeButtonOff();
        captionOff();
        overlayOff();
        activityIndicatorOff();
      },
      onLoadStart: function() {
        captionOff();
        activityIndicatorOn();
      },
      onLoadEnd: function() {
        captionOn();
        activityIndicatorOff();
      }
    });
});

$(document).ready(function() {
  window._.each($('.stories a'), function(link) {
    $('<img />').attr('src', link.href);
  });
});

