# ROUTER

class window.AppRouter extends Backbone.Router
  
  routes:
    "": "electionsList"
    ":namespace/:candidacies/:tag": "compare"
    ":namespace/:candidacies": "tagsList"
    ":namespace": "candidatesList"
  
  electionsList: ->
    unless @electionsListView
      @electionsListView = new ElectionsListView(el: "#elections-list", collection: app.collections.elections, model: app.models.election)
      @electionsListView.render()
    
    # get elections
    if _.isEmpty app.collections.elections.models
      app.collections.elections.fetch()
      
    app.views.application.scrollTo $('#elections').offset().top
      
  candidatesList: (namespace)->
    app.models.election.candidacies.unselect()      
    
    # set election using url
    unless _.isEmpty app.collections.elections.models
      election = _.find app.collections.elections.models, (election) ->
        election.namespace() == namespace
      app.models.election.set election.toJSON()
      
    app.views.application.scrollTo $('#candidacies').offset().top
    
  tagsList: (namespace, names)->
    # redirect if /
    unless names
      return @navigate namespace, true
      
    # set candidacies using url
    namespaces = names.split ','
    _.each app.models.election.candidacies.models, (candidacy)->
      candidacy.set selected: true if _.include namespaces, candidacy.namespace()
        
    app.views.application.scrollTo $('#tags').offset().top
    
  compare: (namespace, candidacies, tagNamespace)->
    # redirect if /
    unless tagNamespace
      return @navigate "#{namespace}/#{candidacies}", true
      
    unless @compareView
      @compareView = new CompareView(el: "#propositions-header", collection: app.models.election.tags, model: app.models.election)
      @compareView.render()
      # propositions
      @propositionsView = new PropositionsView(el: "#propositions-list", model: app.models.election, collection: app.collections.propositions)
      @propositionsView.render()
            
    # set candidacies, tag using url
    # candidacies
    namespaces = candidacies.split ','    
    _.each app.models.election.candidacies.models, (candidacy)->
      candidacy.set {selected: true}, {silent: true} if _.include namespaces, candidacy.namespace()
    # tag
    _.each app.models.election.tags.models, (tag)->      
      tag.set selected: true if tag.namespace() == tagNamespace
      
    @propositionsView.loadPropositions()
    app.views.application.scrollTo $('#propositions').offset().top
    
  share: ->
    unless @shareView
      @shareView = new ShareView(el: "#share")
      @shareView.render()
    app.views.application.presentModalView 'share'