class window.CompareView extends Backbone.View

  tag: ->
    app.models.tag
    
  initialize: ->
    app.models.tag.bind "change", @changeTag, @
    
  events:
    "click a.button": "themesClick"
    
  themesClick: ->
    app.router.themesList()
    
  changeTag: ->
    $(".title", @el).html @tag().name()
    
  render: ->
    $(@el).html Mustache.to_html($('#compare-template').html(), tag: @tag())