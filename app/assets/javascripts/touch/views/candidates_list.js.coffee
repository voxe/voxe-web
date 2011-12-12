class window.CandidatesListView extends Backbone.View
  
  initialize: ->
    new iScroll $('#modal-view .table-view-container').get(0)
    
    app.models.election.fetch()
      
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