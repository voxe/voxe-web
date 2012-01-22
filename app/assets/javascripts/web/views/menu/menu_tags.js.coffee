class window.MenuTagsView extends Backbone.View
    
  initialize: ->
    @model.tags.bind "change:selected", @render, @
    
  events:
    "click": "goToPage"
    
  goToPage: ->
    app.router.navigate "#{@model.namespace()}/#{@model.candidacies.toParam()}", true
    
  render: ->
    if !@model.tags.selected()?
      $(@el).html ''
      return @
    $(@el).html Mustache.to_html($('#menu-tags-template').html(), tag: @model.tags.selected().toJSON())
    @.$('li').fadeIn()
    @