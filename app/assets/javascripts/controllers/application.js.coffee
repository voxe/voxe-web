class window.ApplicationController extends Backbone.Router

  routes:
    "elections": "electionsIndex"
    "elections/compare": "electionsCompare"
    "elections/:id": "electionsShow"
  
  electionsIndex: ->
    app.collections.elections.fetch add: true
    
  electionsShow: (electionId) ->
    app.models.election.id = electionId
    app.models.election.fetch()
    
  