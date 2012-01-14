class window.CandidacyCellView extends Backbone.View
  
  initialize: ->
    @model.bind "change", @render, @
          
  events:
    "click": "candidacyClick"
    
  candidacyClick: (e)->
    # change state
    @model.set selected: !@model.get('selected')
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacy-cell-template').html(), candidacy: @model.toJSON())
    if @model.get('selected')
      # css
      @.$('li').addClass 'selected'
    else
      # css
      @.$('li').removeClass 'selected'
    @