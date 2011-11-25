class window.ElectionsIndexView extends Backbone.View
  
  events:
    "click input[type=submit]": "newElection"
    
  newElection: ->
    election = new ElectionModel()
    election.save {name: $("#name").val()}, success: (model) ->
      alert model.id
    return false
  
  initialize: ->
    app.collections.elections.bind 'add', @addElection
    
  addElection: (election)->
    view = new ElectionsIndexElectionView(model: election)
    $('#elections').append(view.render().el)