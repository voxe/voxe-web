# ROUTER

class window.AppRouter extends Backbone.Router
  
  routes:
    "": "electionsList"
    ":namespace/:candidacies/:tag": "compare"
    ":namespace/:candidacies": "themesList"
    ":namespace": "candidatesList"
  
  electionsList: ->
    if _.isEmpty app.collections.elections.models
      app.collections.elections.fetch()
    app.views.navigation.push 'elections-list'
  
  candidatesList: (namespace)->
    unless _.isEmpty app.collections.elections.models
      election = _.find app.collections.elections.models, (election) ->
        election.namespace() == namespace
      app.models.election.set id: election.id
    app.views.navigation.push 'candidacies-list'
    
  themesList: (namespace, names)->
    # set candidacies using url
    app.models.election.bind 'change', (election)=>
      namespaces = names.split ','
      candidacies = _.filter election.candidacies.models, (candidacy)->
        _.include namespaces, candidacy.namespace()
      app.collections.selectedCandidacies.reset candidacies
    app.views.navigation.push 'tags'
    
  compare: (namespace, candidacies, tagNamespace)->
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
    app.views.application.presentModalView 'share'