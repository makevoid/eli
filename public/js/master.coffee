`$(function(){`


x = undefined

# $('#gallery').mousemove (event) ->
#   if x == undefined
#     x = event.pageX
#   else
#     y = event.pageX - x
#     $("#gallery").css({ left: y+"px" })
#     console.log y

$("#invert_bg").click ->
  $('body').toggleClass "dark"


transforms_unsupporteds = $.browser.msie || $.browser.mozilla || (!$("body").css("WebkitTransform") && !$("body").css("MozTransform"))
  
enableNext = ->
  $("#next").addClass "enabled"
revealPhoto = ->
  $(".photo").css({ display: "block" })
  if transforms_unsupporteds
    $(".photo, #home img").animate({ opacity: 1 }, 1000)
  else
    $(".photo, #home img").css({ opacity: 1 })


c_height = c_width = 0
get_dimensions = -> 
  c_height = $(window).height() - (40+$("header").height())
  #c_height = $("#over").height()
  c_width =  $("#over").width()

get_dimensions()


pos = 0
photos = $(".photo").size()



update_position = (now) ->
  value = -c_width*pos + 20*pos
  if transforms_unsupporteds
    $("#gallery").animate({ left: value }, 500)
  else  
    value = "translate("+(value)+"px)"
    $("#gallery").css({ webkitTransform: value, "-moz-transform": value })

update_pos = -> 
  update_position()
  
  if pos == photos-1
    $("#next").removeClass "enabled"
  else
    $("#next").addClass "enabled"
  if pos > 0
    $("#prev").addClass "enabled"
  else
    $("#prev").removeClass "enabled"

next_photo = ->
  if $("#next").hasClass "enabled"
    pos++
    update_pos()

$(".photo img").click ->
  next_photo()

$("#next").click ->
  next_photo()

$("#prev").click ->
  if $(this).hasClass "enabled"
    pos--
    update_pos()

setTimeout(enableNext, 1500)
setTimeout(revealPhoto, 500)


#console.log "container: w:"+c_width+" h:"+c_height

resizePhoto = (photo) ->
  width = c_width - 60
  ratio = width / c_height
  width = ratio * c_height
  $(photo).css({ width: width+"px" })
  width = Math.max(width, 200)

resizeImg = (photo) ->
  width = c_width - 80
  ratio = width / c_height
  width = ratio * c_height
  console.log(photo.height/photo.width)
  if photo.height > photo.width
    width = Math.min(width, c_width)
    width = Math.min(width, c_height / (photo.height/photo.width))
  else  
    width = Math.min(width, c_width)
    width = Math.max(width, 200)
  $(photo).css({ width: width+"px" })

resizeAll = ->
  $.each(
    $(".photo img"), 
    (idx, photo) ->
      photo = $(".photo")[idx]
      $(photo).css({ width: c_width+"px" })
      resizePhoto(photo)
      resizeImg $(".photo img")[idx]
  )

setTimeout(get_dimensions, 50)
setTimeout(update_position, 50)
setTimeout(resizeAll, 50)
setTimeout(resizeAll, 500)
setTimeout(resizeAll, 1000)
setTimeout(resizeAll, 4000)

$(window).resize( ->
  get_dimensions()
  update_position()
  resizeAll()
)

`})`