# ROUTER

class window.AppRouter extends Backbone.Router
  
  routes:
    "": "electionsList"
    ":namespace/:candidacies/:tag": "comparison"
    ":namespace/:candidacies": "tagsList"
    ":namespace": "candidatesList"
  
  electionsList: ->
    @trackPageview()
    unless @electionsListView
      @electionsListView = new ElectionsListView(el: "#elections-list", collection: app.collections.elections, model: app.models.election)
      @electionsListView.render()
    
    # get elections
    if _.isEmpty app.collections.elections.models
      app.collections.elections.fetch()
      
    app.views.application.scrollTo $('#elections').offset().top
      
  candidatesList: (namespace)->
    @trackPageview()
    app.models.election.candidacies.unselect()
    
    # set election using url
    unless _.isEmpty app.collections.elections.models
      election = _.find app.collections.elections.models, (election) ->
        election.namespace() == namespace
      app.models.election.set id: election.id
      
    app.views.application.scrollTo $('#candidacies').offset().top
    
  tagsList: (namespace, names)->
    @trackPageview()
    # redirect if /
    unless names
      return @navigate namespace, true
      
    # set candidacies using url
    namespaces = names.split ','
    _.each app.models.election.candidacies.models, (candidacy)->
      candidacy.set selected: true if _.include namespaces, candidacy.namespace()
        
    app.views.application.scrollTo $('#tags').offset().top
    
  comparison: (namespace, candidacies, tagNamespace)->
    @trackPageview()
    # redirect if /
    unless tagNamespace
      return @navigate "#{namespace}/#{candidacies}", true
      
    unless @comparisonView
      @comparisonView = new ComparisonView(el: "#comparison", election: app.models.election)
            
    # set candidacies, tag using url
    # candidacies
    namespaces = candidacies.split ','    
    _.each app.models.election.candidacies.models, (candidacy)->
      candidacy.set {selected: true} if _.include namespaces, candidacy.namespace()
    # tag
    _.each app.models.election.tags.models, (tag)->      
      tag.set selected: true if tag.namespace() == tagNamespace
      
    @comparisonView.fetchPropositions()
    
    app.views.application.scrollTo $('#comparison-page').offset().top
    
  share: ->
    unless @shareView
      @shareView = new ShareView(el: "#share")
      @shareView.render()
    app.views.application.presentModalView 'share'

  trackPageview: ->
    # don't track first router call
    if _gaq?
      if lastStaticPageviewTracked['isLastPageview']
        if lastStaticPageviewTracked['path'] != window.location.pathname
          _gaq.push(['_trackPageview'])
        lastStaticPageviewTracked['isLastPageview'] = false
      else
        _gaq.push(['_trackPageview'])
