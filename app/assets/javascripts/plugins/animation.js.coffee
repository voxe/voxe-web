$ ->
  window.app = {}
  
  window.startCompare = ->
    $('#propositions').stop().animate {left: "49px"}, 600
    $('#tags-list').stop().animate {left: "451px"}, 600
    app.tag = true
      
  tagsEnter = ->
    console.log "tagsEnter"
    if app.tag
      $('#tags-list').stop().animate {left: "250px"}, 600
      $('#propositions').stop().animate {left: "-130px"}, 600
      
  tagsLeave = ->
    console.log "tagsLeave"
    if app.tag
      $('#tags-list').stop().animate {left: "451px"}, 600
      $('#propositions').stop().animate {left: "49px"}, 600
    
  candidaciesEnter = ->
    console.log "candidaciesEnter"
    if app.tag
      $('#propositions').stop().animate {left: "220px"}, 600
    
  candidaciesLeave = ->
    console.log "candidaciesLeave"
    if app.tag
      $('#propositions').stop().animate {left: "49px"}, 600
    
  propositionsEnter = ->
    console.log "propositionsEnter"
    
  propositionsLeave = ->
    console.log "propositionsLeave"
    
  $('#tags-list').hover tagsEnter, tagsLeave
  $('#candidacies-list').hover candidaciesEnter, candidaciesLeave
  $('#propositions').hover propositionsEnter, propositionsLeave

# $ ->
#   $('#propositions .container').stickySectionHeaders({
#     stickyClass     : 'sticky',
#     headlineSelector: '.name'
#   });