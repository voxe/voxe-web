class window.CandidacyCellView extends Backbone.View
  
  className: "candidacy"
  tagName: "div"
  
  initialize: ->
    @model.bind "change", @render, @
          
  events:
    "click": "candidacyClick"
    
  candidacyClick: (e)->
    # change state
    # can't add more than two candidacies
    if @model.collection.selected().length == 2
      return false
    @model.set selected: !@model.get('selected')
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacy-cell-template').html(), candidacy: @model.toJSON())
    if @model.get('selected')
      # css
      $(@el).addClass 'selected'
    else
      # css
      $(@el).removeClass 'selected'
    @