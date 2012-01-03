class window.CandidaciesListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
      
  events:
    "click ul li": "candidacyClick"
    
  candidacyClick: (e)->
    $li = $(e.target).closest('li')
    candidacyId = $($li).attr("candidacy-id")
    $li.toggleClass 'selected'
    
    candidacy = app.collections.candidacies.get candidacyId
    if app.collections.selectedCandidacies.get candidacyId
      app.collections.selectedCandidacies.remove candidacy
    else
      app.collections.selectedCandidacies.add candidacy.toJSON()
    app.collections.selectedCandidacies.trigger 'reset'
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacies-list-template').html(), candidacies: @collection.toJSON())