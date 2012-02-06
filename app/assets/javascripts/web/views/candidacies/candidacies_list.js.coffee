class window.CandidaciesListView extends Backbone.View
  
  initialize: ->
    @model.bind "change:candidacies", @render, @
      
  render: ->
    $(@el).html ''
    @model.candidacies.each (candidacy) =>
      view = new CandidacyCellView model: candidacy, election: @model
      $(@el).append view.render().el
    @
