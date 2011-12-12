# iOS only
# hide Safari address bar

hideURLbar= ->
  window.scrollTo 0, 0.9

document.addEventListener "touchstart", hideURLbar, false
window.addEventListener "load", ->
  setTimeout hideURLbar, 0
  
# implement custom scrolling to enable fixed positioning
# credits: http://cubiq.org/iscroll-4

# document.addEventListener(
#   'touchmove', (e) ->
#     e.preventDefault()
#   ,false
# )