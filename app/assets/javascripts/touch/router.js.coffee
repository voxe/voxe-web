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
    
    app.views.navigation.push 'elections-list'
  
  candidatesList: (namespace)->
    unless @candidaciesListView
      @candidaciesListView = new CandidaciesListView(el: "#candidacies-list", model: app.models.election)
      @candidaciesListView.render()
    
    unless _.isEmpty app.collections.elections.models
      election = _.find app.collections.elections.models, (election) ->
        election.namespace() == namespace
      app.models.election.set id: election.id
    
    app.views.navigation.push 'candidacies-list'
    
  tagsList: (namespace, names)->
    # redirect if /
    unless names
      return @navigate namespace, true
    
    unless @tagsListView
      @tagsListView = new TagsListView(el: "#tags")
      @tagsListView.render()
      
    # set candidacies using url
    app.models.election.bind 'change', (election)=>
      namespaces = names.split ','
      candidacies = _.filter election.candidacies.models, (candidacy)->
        _.include namespaces, candidacy.namespace()
      app.collections.selectedCandidacies.reset candidacies
    
    app.views.navigation.push 'tags'
    
  compare: (namespace, candidacies, tagNamespace)->
    # redirect if /
    unless tagNamespace
      return @navigate "#{namespace}/#{candidacies}", true
      
    unless @compareView
      @compareView = new CompareView(el: "#compare")
      @compareView.render()
      view = new PropositionsView(el: "#compare .table-view")
      view.render()
      
    # set candidacies, tag using url
    app.models.election.bind 'change', (election)=>
      # candidacies
      namespaces = candidacies.split ','
      candidacies = _.filter election.candidacies.models, (candidacy)->
        _.include namespaces, candidacy.namespace()
      app.collections.selectedCandidacies.reset candidacies
      # tag
      tag = _.find election.tags.models, (_tag) ->
        _tag.namespace() == tagNamespace
      app.models.tag.set tag.toJSON()
    
    app.views.navigation.push 'compare'
    
  share: ->
    unless @shareView
      @shareView = new ShareView(el: "#share")
      @shareView.render()
    app.views.application.presentModalView 'share'