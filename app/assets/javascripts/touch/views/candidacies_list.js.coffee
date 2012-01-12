class window.CandidaciesListView extends Backbone.View
  
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
      
  events:
    "click a.nav": "backClick"
    "click ul.candidacies li": "candidacyClick"
    "click a.compare": "compareClick"
    
  backClick: ->
    app.router.navigate '', true
    
  candidacyClick: (e)->
    li = $(e.target).closest('li')
    candidacyId = $(li).attr("candidacy-id")
    li.toggleClass 'selected'
    
    candidacy = app.collections.candidacies.get candidacyId
    if app.collections.selectedCandidacies.get candidacyId
      app.collections.selectedCandidacies.remove candidacy
    else
      app.collections.selectedCandidacies.add candidacy.toJSON()
    
  compareClick: ->
    app.router.navigate "#{app.models.election.namespace()}/#{app.collections.selectedCandidacies.toParam()}", true
    
    unless @scrollView
      @scrollView = new iScroll $('#tags .table-view-container').get(0)
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacies-list-template').html(), election: @election().toJSON())
    new iScroll $('.table-view-container', @el).get(0)
    setTimeout hideURLbar, 0