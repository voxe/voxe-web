class window.CandidacyCellView extends Backbone.View
  
  initialize: ->
    # @selected = false
          
  events:
    "click": "candidacyClick"
    
  candidacyClick: (e)->
    candidacyId = @.$('li').attr("candidacy-id")
    @selected = !@selected
    @.$('input').attr 'checked', @selected
    
    @.$('li').toggleClass 'selected'
    
    candidacy = app.collections.candidacies.get candidacyId
    if app.collections.selectedCandidacies.get candidacyId
      app.collections.selectedCandidacies.remove candidacy
    else
      app.collections.selectedCandidacies.add candidacy.toJSON()
    app.collections.selectedCandidacies.trigger 'reset'
      
  render: ->
    $(@el).html Mustache.to_html($('#candidacy-cell-template').html(), candidacy: @model.toJSON())

    @candidacyClick() if @options.selected

    @
