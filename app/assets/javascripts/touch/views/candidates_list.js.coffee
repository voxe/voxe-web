class window.CandidatesListView extends Backbone.View
  
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
      
  events:
    "click ul.candidates li": "candidateClick"
    "click a.button": "compareClick"
    
  candidateClick: (e)->
    li = $(e.target).closest('li')
    candidateId = $(li).attr("candidate-id")
    li.toggleClass 'selected'
    
    candidate = app.collections.candidates.get candidateId
    if app.collections.selectedCandidates.get candidateId
      app.collections.selectedCandidates.remove candidate
    else
      app.collections.selectedCandidates.add candidate.toJSON()
    
  compareClick: ->      
    app.views.application.dissmissModalView()
    
    unless @scrollView
      @scrollView = new iScroll $('#themes .table-view-container').get(0)
      
  render: ->
    $(@el).html Mustache.to_html($('#candidates-list-template').html(), election: @election())
    new iScroll $('.table-view-container', @el).get(0)
    setTimeout hideURLbar, 0