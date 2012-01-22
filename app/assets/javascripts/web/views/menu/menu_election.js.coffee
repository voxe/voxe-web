class window.MenuElectionView extends Backbone.View
  
  tagName: 'li'
  className: 'election'
  
  initialize: ->
    @model.bind "change:name", @render, @
    
  events:
    "click": "goToPage"
    
  goToPage: ->
    # app.views.application.scrollTo $('#elections').offset().top
    app.router.navigate "", true
    
  render: ->
    $(@el).html Mustache.to_html($('#menu-election-template').html(), election: @model.toJSON())
    $(@el).fadeIn()
    @