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
    election = _.find app.collections.elections.models, (election) ->
      election.namespace() == namespace
    app.models.election.set id: election.id
    app.views.navigation.push 'candidacies-list'
    
  themesList: ->
    app.views.navigation.push 'tags'
    
  compare: ->
    app.views.navigation.push 'compare'
    
  share: ->
    app.views.application.presentModalView 'share'