class window.EmbedModel extends Backbone.Model
  
  initialize: ->
    # youtube id
    @youtube = @get("url").match('v=([^&]*)')[1]
    
    @set imageUrl: "http://img.youtube.com/vi/#{@youtube}/hqdefault.jpg"