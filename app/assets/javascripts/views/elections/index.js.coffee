class window.ElectionsIndexView extends Backbone.View
  
  initialize: ->
    app.collections.elections.bind 'add', @addElection
    
  addElection: (election)->
    alert 'addElection'