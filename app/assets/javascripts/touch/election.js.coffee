class window.VoxeElection
  
  constructor: (options)->    
    window.app = {models: {}, collections: {}, views:{}}
    
    app.router = new AppRouter()
    
    app.collections.elections = new ElectionsCollection()
    
    app.models.election = new ElectionModel()
    app.models.tag = new TagModel()
    
    app.collections.tags = app.models.election.tags
    app.collections.candidacies = app.models.election.candidacies
    
    app.collections.selectedCandidacies = new CandidaciesCollection()
    app.collections.propositions = new PropositionsCollection()
    
    app.views.application = new ApplicationView(el: "#application-view")
    app.views.navigation = new NavigationView(el: "#navigation-view")
        
    app.models.election.bind "change:id", (election)->
      app.models.election.fetch()
    
    if options.electionId
      app.models.election.set id: options.electionId
    
    Backbone.history.start pushState: true
    
