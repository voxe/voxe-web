class window.ElectionsShowView extends Backbone.View
  
  initialize: ->
    app.models.election.bind 'change', (model) =>
      model.get('candidates').each (candidate) =>
        @addCandidate candidate
        
      model.get('themes').each (theme) =>
        @addTheme theme
        
  addCandidate: (candidate)->
    view = new ElectionsShowCandidateView(model: candidate)
    $('#candidates').append(view.render().el)
    
  addTheme: (theme)->
    view = new ElectionsShowThemeView(model: theme)
    $('#themes').append(view.render().el)