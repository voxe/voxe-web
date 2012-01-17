class window.ElectionCellView extends Backbone.View

  initialize: ->
    @model.bind "change", @render, @
          
  events:
    "click": "electionClick"
    
  electionClick: (e)->
    app.router.navigate @model.namespace(), true
      
  render: ->
    $(@el).html Mustache.to_html($('#election-cell-template').html(), election: @model.toJSON())
    $(@el).fadeIn 500
    @