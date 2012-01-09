class window.PropositionView extends Backbone.View
  events:
    "click a.close": "close"
    
  initialize: ->
    app.models.proposition.bind "change", @render, @
  
  close: ->
    $('.modal').fadeOut(200)
    
  candidacies:(proposition) ->
    _.map proposition.candidacy(), (c) ->
      app.collections.selectedCandidacies.get c
  
  proposition: ->
    proposition = app.collections.propositions.get app.models.proposition.id
    proposition.set {candidacies: @candidacies(proposition)}
    proposition
  
  render: ->
    proposition = @proposition()
    console.log proposition
    $("#quote", @el).html Mustache.to_html($('#proposition-template').html(), proposition: proposition)
    $('.modal').fadeIn(200)