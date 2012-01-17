class window.VoxeWeb
  
  constructor: (options)->    
    window.app = {models: {}, collections: {}, views:{}}
    
    app.router = new AppRouter()
    
    app.collections.elections = new ElectionsCollection()
    
    app.models.election = new ElectionModel()
    
    app.collections.tags = app.models.election.tags
    app.collections.candidacies = app.models.election.candidacies
    
    app.collections.propositions = new PropositionsCollection()
    
    app.views.application = new ApplicationView(el: "#application-view")
    app.views.menu = new MenuView(el: "#menu", model: app.models.election)
    app.views.menu.render()
        
    app.models.election.bind "change:id", (election)->
      app.models.election.fetch()
    
    if options.electionId
      app.models.election.set id: options.electionId
    
    Backbone.history.start pushState: true

$ ->
  height = $(window).height()
  $('body').animate scrollTop: "1px", 0
  $('.page').css 'min-height', height - 50