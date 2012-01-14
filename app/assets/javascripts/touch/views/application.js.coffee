class window.ApplicationView extends Backbone.View
    
  presentModalView: (id)->
    $("##{id}.modal-view").show()
    $('#navigation-view').hide()
    
  dissmissModalView: ->
    $('.modal-view').hide()
    $('#navigation-view').show()