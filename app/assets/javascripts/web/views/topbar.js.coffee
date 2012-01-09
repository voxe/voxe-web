class window.TopbarView extends Backbone.View
  
  initialize: ->
    app.collections.selectedCandidacies.bind "all", @render, @
      
  events:
    "click a": "selection"
  
  selection: ->
    $('#compare').fadeOut()
    $("#select-candidates").animate({'top': '30%'}, 500)
    
  render: ->
    s = 's' if app.collections.selectedCandidacies.length >= 2
    $(@el).html Mustache.to_html($('#topbar-template').html(), candidates: {length: app.collections.selectedCandidacies.length, s: s})