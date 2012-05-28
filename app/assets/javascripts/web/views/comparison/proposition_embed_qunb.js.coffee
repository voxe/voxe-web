class window.PropositionEmbedQunbView extends Backbone.View
  
  events:
    "click": "play"
    
  play: ->
    theater = new TheaterView width: '640'
    theater.play "<iframe class='youtube-player' frameborder='0' type='text/html' width='640' height='410' src='http://www.qunb.com/Embed.html?id=#{@model.qunb}&title=#{@model.get('title')}'></iframe>"
  
  render: ->
    $(@el).html Mustache.to_html($('#proposition-embed-dataviz-template').html(), embed: @model.toJSON())
    @
