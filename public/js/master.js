(function() {
  $(function(){;
  var c_height, c_width, enableNext, get_dimensions, next_photo, photos, pos, resizeAll, resizeImg, resizePhoto, revealPhoto, transforms_unsupporteds, update_pos, update_position, x;
  x = void 0;
  $("#invert_bg").click(function() {
    return $('body').toggleClass("dark");
  });
  transforms_unsupporteds = $.browser.msie || $.browser.mozilla || (!$("body").css("WebkitTransform") && !$("body").css("MozTransform"));
  enableNext = function() {
    return $("#next").addClass("enabled");
  };
  revealPhoto = function() {
    $(".photo").css({
      display: "block"
    });
    if (transforms_unsupporteds) {
      return $(".photo, #home img").animate({
        opacity: 1
      }, 1000);
    } else {
      return $(".photo, #home img").css({
        opacity: 1
      });
    }
  };
  c_height = c_width = 0;
  get_dimensions = function() {
    c_height = $(window).height() - (40 + $("header").height());
    return c_width = $("#over").width();
  };
  get_dimensions();
  pos = 0;
  photos = $(".photo").size();
  update_position = function(now) {
    var value;
    value = -c_width * pos + 20 * pos;
    if (transforms_unsupporteds) {
      return $("#gallery").animate({
        left: value
      }, 500);
    } else {
      value = "translate(" + value + "px)";
      return $("#gallery").css({
        webkitTransform: value,
        "-moz-transform": value
      });
    }
  };
  update_pos = function() {
    update_position();
    if (pos === photos - 1) {
      $("#next").removeClass("enabled");
    } else {
      $("#next").addClass("enabled");
    }
    if (pos > 0) {
      return $("#prev").addClass("enabled");
    } else {
      return $("#prev").removeClass("enabled");
    }
  };
  next_photo = function() {
    if ($("#next").hasClass("enabled")) {
      pos++;
      return update_pos();
    }
  };
  $(".photo img").click(function() {
    return next_photo();
  });
  $("#next").click(function() {
    return next_photo();
  });
  $("#prev").click(function() {
    if ($(this).hasClass("enabled")) {
      pos--;
      return update_pos();
    }
  });
  setTimeout(enableNext, 1500);
  setTimeout(revealPhoto, 500);
  resizePhoto = function(photo) {
    var ratio, width;
    width = c_width - 60;
    ratio = width / c_height;
    width = ratio * c_height;
    $(photo).css({
      width: width + "px"
    });
    return width = Math.max(width, 200);
  };
  resizeImg = function(photo) {
    var ratio, width;
    width = c_width - 80;
    ratio = width / c_height;
    width = ratio * c_height;
    // console.log(photo.height / photo.width);
    if (photo.height > photo.width) {
      width = Math.min(width, c_width);
      width = Math.min(width, c_height / (photo.height / photo.width));
    } else {
      width = Math.min(width, c_width);
      width = Math.max(width, 200);
    }
    return $(photo).css({
      width: width + "px"
    });
  };
  resizeAll = function() {
    return $.each($(".photo img"), function(idx, photo) {
      photo = $(".photo")[idx];
      $(photo).css({
        width: c_width + "px"
      });
      resizePhoto(photo);
      return resizeImg($(".photo img")[idx]);
    });
  };
  setTimeout(get_dimensions, 50);
  setTimeout(update_position, 50);
  setTimeout(resizeAll, 50);
  setTimeout(resizeAll, 500);
  setTimeout(resizeAll, 1000);
  setTimeout(resizeAll, 4000);
  $(window).resize(function() {
    get_dimensions();
    update_position();
    return resizeAll();
  });
  });
}).call(this);
