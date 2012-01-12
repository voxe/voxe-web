class window.CandidaciesListView extends Backbone.View
  
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
      
  events:
    "mouseenter li": "insideCandidate"
    "mouseleave li": "outsideCandidate"
    "click li": "selectCandidate"

  insideCandidate:(e) ->
    $('span', e.currentTarget).clearQueue().animate({left: '-14'}, 200)
      
  outsideCandidate:(e) ->
    $('span', e.currentTarget).clearQueue().animate({left: '-78'}, 200)
    
  selectCandidate:(e) ->
    $('span', e.currentTarget).fadeToggle(100);
    
    candidacyId = $(e.currentTarget).attr("candidacy-id")
    candidacy = app.collections.candidacies.get candidacyId
    if app.collections.selectedCandidacies.get candidacyId
      app.collections.selectedCandidacies.remove candidacy
    else
      app.collections.selectedCandidacies.add candidacy.toJSON()
    
  render: ->
    $(@el).html Mustache.to_html($('#candidacies-list-template').html(), election: @election().toJSON())
    $(@el).delay(300).slideToggle()