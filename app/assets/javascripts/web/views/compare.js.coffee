class window.CompareView extends Backbone.View

  tag: ->
    app.models.tag
    
  initialize: ->
    app.models.tag.bind "change", @changeTag, @
    
  changeTag: ->
    $('#no-selection').fadeOut()
    $("h1", @el).html @tag().name()
    $(@el).fadeIn()
    
  render: ->
    $(@el).html Mustache.to_html($('#compare-template').html(), tag: @tag())