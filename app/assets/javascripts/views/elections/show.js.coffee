class window.ElectionsShowView extends Backbone.View
  
  events:
    "submit #add-candidate": "newCandidate"
    "submit #add-theme": "newTheme"
    
  newCandidate: (e)->
    alert 'addCandidate'
    
    e.preventDefault()
    
  newTheme: (e)->
    alert 'addTheme'
    e.preventDefault()
  
  initialize: ->
    @themesCollection = new ElectionThemesCollection()
    
    app.models.election.bind 'change', (model) =>
      @themesCollection.electionId = model.id
      
      $("#election").html @render().el
      
      # _.each model.get('candidates'), (candidate) =>
      #   @addCandidate candidate
      #   
      # _.each model.get('themes'), (theme) =>
      #   @addTheme theme
        
  addCandidate: (candidate)->
    view = new ElectionsShowCandidateView(model: candidate)
    $('#candidates').append(view.render().el)
    
  addTheme: (theme)->
    view = new ElectionsShowThemeView(model: theme)
    $('#themes').append(view.render().el)
    
  render: ->
    $(@el).html JST["elections/show"](app.models.election.toJSON())
    @