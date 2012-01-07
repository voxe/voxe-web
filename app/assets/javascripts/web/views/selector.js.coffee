class window.SelectorView extends Backbone.View
  events:
    "click #next-step a": "nextStep"
  
  switchButton: ->
    length = app.collections.selectedCandidacies.length

    if length == 0
      text = 'Sélectionnez vos candidats'
    else if length == 1
      text = 'Voir le programme'
    else
      text = 'Comparez ces candidats'

    if length >= 1
      $('#next-step a', @el).animate({opacity: 1}, 200).text(text)
    else
      $('#next-step a', @el).animate({opacity: 0.4}, 200).text(text)
  
  nextStep: =>
    length = app.collections.selectedCandidacies.length
    
    if length > 0
      $(@el).animate({'top': '-100%'}, 700)
      $('#compare').fadeIn()