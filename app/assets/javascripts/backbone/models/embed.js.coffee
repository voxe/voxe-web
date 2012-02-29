class window.EmbedModel extends Backbone.Model
  
  initialize: ->
    # youtube id
    if @get('provider_name') is "YouTube"
      @youtube = @get("url").match('v=([^&]*)')[1]

      @set imageUrl: "http://img.youtube.com/vi/#{@youtube}/hqdefault.jpg"
      
  type: ->
    @get "type"
    
  isLink: ->
    @type() == "link"
    
  isVideo: ->
    @type() == "video"