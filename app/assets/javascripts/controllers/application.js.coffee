class window.ApplicationController extends Backbone.Router

  routes:
    "elections": "elections"
  
  elections: ->
    alert 'elections'
    app.collections.elections.fetch()