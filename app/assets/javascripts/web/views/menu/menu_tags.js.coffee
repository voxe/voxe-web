class window.MenuTagsView extends Backbone.View
    
  initialize: ->
    @model.tags.bind "change:selected", @render, @
    
  events:
    "click .theme": "goToPage"
    "click .section": "goToSection"
    
  goToPage: ->
    app.router.navigate "#{@model.namespace()}/#{@model.candidacies.toParam()}", true

  goToSection: (event) ->
    app.views.application.scrollTo $("#tag-#{event.target.dataset.tagId}").offset().top
    
  render: ->
    if !@model.tags.selected()?
      $(@el).html ''
      return @
    $(@el).html Mustache.to_html($('#menu-tags-template').html(), tag: @model.tags.selected().toJSON())
    @.$('li').fadeIn()
    @