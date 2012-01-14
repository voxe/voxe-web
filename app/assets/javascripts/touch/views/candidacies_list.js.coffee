class window.CandidaciesListView extends Backbone.View
  
  initialize: ->
    @model.bind "change", @render, @
    @candidacyNamespaces = []
      
  events:
    "click a.nav": "backClick"
    "click a.compare": "compareClick"
    
  backClick: ->
    app.router.navigate '', true
    
  compareClick: ->
    app.router.navigate "#{@model.namespace()}/#{@model.candidacies.toParam()}", true
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacies-list-template').html(), election: @model.toJSON())
    $candidacies = @.$('ul')
    @model.candidacies.each (candidacy) =>
      view = new CandidacyCellView model: candidacy
      $candidacies.append view.render().el
    new iScroll $('.table-view-container', @el).get(0)
    setTimeout hideURLbar, 0
    @