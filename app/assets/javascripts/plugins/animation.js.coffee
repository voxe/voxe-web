$ ->
  $('#propositions .container').stickySectionHeaders({
    stickyClass     : 'sticky',
    headlineSelector: '.name'
  });
  
  tagsEnter = ->
    $('#tags').stop().animate {left: "250px", opacity: "1.0"}, 400, ->
      $(@).css "overflow-y", "auto"
      
    $('#propositions').css "overflow-y", "hidden"
    $('#propositions').stop().animate {left: "-150px", opacity: "0.9"}, 400
    
    $('#candidacies').stop().animate {left: "-300px", opacity: "0.9"}, 400
    
  tagsLeave = ->
    $('#tags').css "overflow-y", "hidden"
    $('#tags').stop().animate {left: "450px", opacity: "0.9"}, 400
    
    $('#propositions').stop().animate {left: "49px", opacity: "1.0"}, 400, ->
      $(@).css "overflow-y", "auto"
      
    $('#candidacies').stop().animate {left: "0", opacity: "0.9"}, 400
    
  $('#tags-list li').click ->
    $('#propositions-compare').stop().animate {left: "145px"}, 400
    
  candidaciesEnter = ->
    $('#propositions').css "overflow-y", "hidden"
    $('#propositions').stop().animate {left: "300px", opacity: "0.9"}, 400
    
    $('#tags').stop().animate {left: "700px", opacity: "0.9"}, 400
    
    $('#candidacies').stop().animate {opacity: "1.0"}, 400, ->
      $(@).css "overflow-y", "auto"
    
  candidaciesLeave = ->
    $('#propositions').stop().animate {left: "49px", opacity: "1.0"}, 400, ->
      $(@).css "overflow-y", "auto"
      
    $('#tags').stop().animate {left: "450px"}, 400
    
    $('#candidacies').css "overflow-y", "hidden"
    $('#candidacies').stop().animate {opacity: "0.9"}, 400
          
  $('#tags').hover tagsEnter, tagsLeave
  $('#candidacies').hover candidaciesEnter, candidaciesLeave
  
  $('#tags li').click ->
    $(@).toggleClass 'selected'
    
  $('#candidacies li').click ->
    $(@).toggleClass 'selected'