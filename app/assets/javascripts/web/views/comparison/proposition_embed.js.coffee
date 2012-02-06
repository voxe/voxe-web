class window.PropositionEmbedView extends Backbone.View
  
  className: "proposition-embed"
    
  events:
    "click": "play"
    
  play: ->
    theater = new TheaterView width: '640'
    
    theater.play "<iframe class='youtube-player' type='text/html' width='640' height='385' src='http://www.youtube.com/embed/#{@model.youtube}' frameborder='0'></iframe>"
  
  render: ->
    $(@el).html Mustache.to_html($('#proposition-embed-template').html(), embed: @model.toJSON())
    @