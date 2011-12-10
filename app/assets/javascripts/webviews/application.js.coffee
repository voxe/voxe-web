$ ->
  for element in $('.proposition a')
    new google.ui.FastButton element, (e)->
      window.location = e.target