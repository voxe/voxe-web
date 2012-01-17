class window.CompareView extends Backbone.View
    
  initialize: ->
    @collection.bind "change:selected", @render, @
    
  render: ->
    if !@collection.selected()?
      return @
    $(@el).html Mustache.to_html($('#compare-template').html(), tag: @collection.selected().toJSON())
    @