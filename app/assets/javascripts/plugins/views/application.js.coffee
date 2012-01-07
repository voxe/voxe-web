class window.ApplicationView extends Backbone.View
  
  initialize: ->
    @model.bind 'change', @setElectionName
    @width = $('#app').width()
    @height = $('#app').height()
    
  setElectionName: =>
    @.$('#header .container').html @model.name()
    
  render: ->
    $(@el).html Mustache.to_html($('#application-template').html(), election: @model.toJSON())
    @