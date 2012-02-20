class window.PropositionEmbedYoutubeView extends Backbone.View
  
  events:
    "click": "play"
    
  play: ->
    theater = new TheaterView width: '640'
    theater.play "<iframe class='youtube-player' type='text/html' width='640' height='385' src='http://www.youtube.com/embed/#{@model.youtube}?autoplay=1' frameborder='0'></iframe>"
  
  render: ->
    $(@el).html Mustache.to_html($('#proposition-embed-video-template').html(), embed: @model.toJSON())
    @

