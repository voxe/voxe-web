class window.ApplicationView extends Backbone.View
  
  initialize: ->
    @model.bind "change", @render, @
    
  render: ->
    $(@el).html Mustache.to_html($('#application-template').html(), tags: @collection.toJSON())