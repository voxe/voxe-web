class window.PropositionView extends Backbone.View
  events:
    "click a.close": "close"
    
  initialize: ->
    app.models.proposition.bind "change", @render, @
  
  close: ->
    $('.modal').fadeOut(200)
  
  proposition: ->
    app.collections.propositions.get app.models.proposition.id
  
  render: ->
    console.log @proposition()
    $("#quote", @el).html Mustache.to_html($('#proposition-template').html(), proposition: @proposition())
    $('.modal').fadeIn(200)