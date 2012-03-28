class window.VoxeElection
  
  constructor: (options)->
    # mobile
    if navigator && navigator.userAgent && navigator.userAgent.match(/iphone|android/i)
      $("#touch").show()
      return true
          
    window.app = {models: {}, collections: {}, views:{}}
        
    app.models.election = new ElectionModel()
    
    app.models.election.bind 'change:id', (election)=>
      election.fetch data: {tags: 'all'}
      
    app.models.tag = new TagModel()
    
    app.collections.tags = new TagsCollection()
    app.models.election.bind 'change:tags', (election)=>
      app.collections.tags.reset election.tags.toJSON()
    
    app.collections.candidacies = new CandidaciesCollection()
    app.models.election.bind 'change:candidacies', (election)=>
      app.collections.candidacies.reset election.candidacies.toJSON()
    
    app.collections.selectedCandidacies = new CandidaciesCollection()
    app.collections.propositions = new PropositionsCollection()
    
    app.views.application = new ApplicationView(model: app.models.election)
    $('#app').html app.views.application.render().el

    app.views.candidaciesList = new CandidaciesListView(collection: app.collections.candidacies, el: "#candidacies-list", defaultCandidacyIds: options.defaultCandidacyIds)
    app.views.tagsList = new TagsListView(collection: app.collections.tags, el: "#tags-list", defaultTagId: options.defaultTagId)
    
    app.views.propositions = new PropositionsView(el: "#propositions")

    app.models.election.set {id: options.electionId}
