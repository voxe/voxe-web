class window.EmbedModel extends Backbone.Model
  
  initialize: ->
    # youtube id
    switch @get('provider_name')
      when "YouTube"
        @youtube = @get("url").match('v=([^&]*)')[1]
        @set imageUrl: "http://img.youtube.com/vi/#{@youtube}/hqdefault.jpg"
      when "qunb"
        @qunb = @get("url").match('qunb.com/Website.html#!Viz:([0-9]+)')[1]
        @set imageUrl: "http://images.qunb.com/viz/#{@qunb}?size=thumb"
  type: ->
    @get "type"
    
  isLink: ->
    @type() == "link"
    
  isVideo: ->
    @type() == "video"

  isDataviz: ->
    @type() == "dataviz"
