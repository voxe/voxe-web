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
    
    app.views.electionsList = new ElectionsListView(el: "#elections-list", collection: app.collections.elections, model: app.models.election)

    app.views.candidaciesList = new CandidaciesListView(el: "#candidacies-list", model: app.models.election)
    app.views.tagsList = new TagsListView(el: "#tags")
    
    app.views.compare = new CompareView(el: "#compare")
    app.views.compare.render()
    app.views.propositions = new PropositionsView(el: "#compare .table-view")
    
    app.views.share = new ShareView(el: "#share")
    app.views.share.render()
    
    app.models.election.bind "change:id", (election)->
      app.models.election.fetch()
    
    if options.electionId
      app.models.election.set id: options.electionId

    Backbone.history.start pushState: true