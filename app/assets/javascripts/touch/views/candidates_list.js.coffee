class window.CandidatesListView extends Backbone.View
      
  events:
    "click ul.candidates li": "candidateClick"
    "click a.button": "compareClick"
    
  candidateClick: (e)->
    li = $(e.target).closest('li')
    candidateId = $(li).attr("candidate-id")
    li.toggleClass 'selected'
    # alert candidateId
    # candidate = app.collections.candidates.get candidateId
    # if candidate.get 'selected'
    #   candidate.set {selected: false}
    # else
    #   candidate.set {selected: true}
    
  compareClick: ->      
    app.router.navigate "themes", true