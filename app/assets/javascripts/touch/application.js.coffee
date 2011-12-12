# iOS only
# hide Safari address bar

window.hideURLbar= ->
  window.scrollTo 0, 0.9

document.addEventListener "touchstart", hideURLbar, false
  
# implement custom scrolling to enable fixed positioning
# credits: http://cubiq.org/iscroll-4

# document.addEventListener(
#   'touchmove', (e) ->
#     e.preventDefault()
#   ,false
# )