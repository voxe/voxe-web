class window.VoxeElection
  
  constructor: (options)->    
    window.app = {models: {}, collections: {}, views:{}}
    
    app.models.election = new ElectionModel()
    app.models.tag = new TagModel()
    
    app.collections.tags = new TagsCollection()
    app.models.election.bind 'change', (election)=>
      app.collections.tags.add election.tags()
    
    app.collections.candidacies = new CandidaciesCollection()
    app.models.election.bind 'change', (election)=>
      app.collections.candidacies.add election.candidacies()
    
    app.collections.selectedCandidacies = new CandidaciesCollection()
    app.collections.propositions = new PropositionsCollection()
    
    app.views.application = new ApplicationView(el: "#application-view")
    app.views.navigation = new NavigationView(el: "#navigation-view")

    app.views.candidaciesList = new CandidaciesListView(el: "#candidacies-list")
    app.views.tagsList = new TagsListView(el: "#tags")
    
    app.views.compare = new CompareView(el: "#compare")
    app.views.compare.render()
    app.views.propositions = new PropositionsView(el: "#compare .table-view")

    app.router = new AppRouter()
    app.router.candidatesList()
    app.views.navigation.push 'tags'
    
    app.models.election.set options.election