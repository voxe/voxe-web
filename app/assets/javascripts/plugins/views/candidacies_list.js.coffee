class window.CandidaciesListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
    $(@el).hover @mouseEnter, @mouseLeave
    
  mouseEnter: =>
    if $('#app').attr 'compare'
      @hover = true
      setTimeout @move, 250
      
  move: =>
    if @hover
      $('#propositions').animate {left: "220px"}, 600
    
  mouseLeave: =>
    if $('#app').attr 'compare'
      @hover = false
      $('#propositions').animate {left: "49px"}, 600
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacies-list-template').html(), candidacies: @collection.toJSON())
    $candidacies = @.$('ul')
    @collection.each (candidacy) ->
      view = new CandidacyCellView model: candidacy, collection: @collection
      $candidacies.append view.render().el
    @