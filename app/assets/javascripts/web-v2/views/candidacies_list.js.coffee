class window.CandidaciesListView extends Backbone.View
  
  initialize: ->
    @model.bind "change:candidacies", @render, @
    @model.candidacies.bind "change:selected", @candidacyClick, @
    
  candidacyClick: (candidacy)->
    if @model.candidacies.selected().length == 2
      app.router.navigate "#{@model.namespace()}/#{@model.candidacies.toParam()}", true
      
  render: ->
    $(@el).html ''
    @model.candidacies.each (candidacy) =>
      view = new CandidacyCellView model: candidacy
      $(@el).append view.render().el
    @