class window.VoxeElection
  
  constructor: (options)->    
    window.app = {models: {}, collections: {}, views:{}}
    
    app.models.election = new ElectionModel()
    app.models.tag = new TagModel()
    app.models.proposition = new PropositionModel()
    
    app.collections.tags = new TagsCollection()
    app.models.election.bind 'change', (election)=>
      app.collections.tags.add election.tags()
    
    app.collections.candidacies = new CandidaciesCollection()
    app.models.election.bind 'change', (election)=>
      app.collections.candidacies.add election.candidacies()
    
    app.collections.selectedCandidacies = new CandidaciesCollection()
    app.collections.propositions = new PropositionsCollection()
    
    app.views.candidaciesList = new CandidaciesListView(el: "#selection")
    app.views.selector = new SelectorView(el: "#select-candidates")
    app.collections.selectedCandidacies.bind 'all', =>
      app.views.selector.switchButton()
      
    app.views.tagsList = new TagsListView(el: "#sidebar")
    app.views.compare = new CompareView(el: "#selected-theme")
    app.views.propositions = new PropositionsView(el: "#selected-theme #propositions")
    
    app.models.election.set options.election
    app.views.modal = new PropositionView(el: "#specific")