class window.ApplicationView extends Backbone.View
  
  events:
    "click #toolbar": "candidatesClick"
      
  candidatesClick: (e)->
    app.router.candidatesList()
    
  presentModalView: (id)->
    $("##{id}.modal-view").show()
    $('#navigation-view').hide()
    
  dissmissModalView: ->
    $('.modal-view').hide()
    $('#navigation-view').show()