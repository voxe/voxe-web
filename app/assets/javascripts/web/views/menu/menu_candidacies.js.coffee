class window.MenuCandidaciesView extends Backbone.View
  
  tagName: 'li'
  className: 'candidacies'
  
  initialize: ->
    @model.candidacies.bind "change:selected", @render, @
    
  events:
    "click": "goToPage"
    
  goToPage: ->
    app.router.navigate "#{@model.namespace()}", true
    
  candidacies: ->
    @model.candidacies.selected().toJSON()
    
  render: ->
    if !@candidacies()[0]? || !@candidacies()[1]?
      return @
    options = candidacy1: @candidacies()[0], candidacy2: @candidacies()[1]
    $(@el).html Mustache.to_html($('#menu-candidacies-template').html(), options)
    $(@el).fadeIn()
    @