class window.ElectionsIndexView extends Backbone.View
  
  initialize: ->
    app.collections.elections.bind 'add', @addElection
    
  addElection: (election)->
    view = new ElectionsIndexElectionView(model: election)
    $('#elections').append(view.render().el)