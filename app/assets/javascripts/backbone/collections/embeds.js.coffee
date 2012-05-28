class window.EmbedsCollection extends Backbone.Collection
  
  model: EmbedModel
  
  links: ->
    @filter (embed) ->
      embed.isLink()
      
  videos: ->
    @filter (embed) ->
      embed.isVideo()
  
  datavizs: ->
    @filter (embed) ->
      embed.isDataviz()
