class window.CandidaciesListView extends Backbone.View
  
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
      
  events:
    "click ul.candidacies li": "candidacyClick"
    "click a.button": "compareClick"
    
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
    app.collections.selectedCandidacies.trigger "reset"
    app.views.application.dissmissModalView()
    
    unless @scrollView
      @scrollView = new iScroll $('#tags .table-view-container').get(0)
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacies-list-template').html(), election: @election())
    new iScroll $('.table-view-container', @el).get(0)
    setTimeout hideURLbar, 0