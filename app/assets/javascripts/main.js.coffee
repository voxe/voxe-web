window.app = {}
app.controllers = {}
app.models = {}
app.collections = {}
app.views = {}

$(document).ready ->
  # backbone collections
  app.collections.elections = new ElectionsCollection()
  
  # backbone models
  app.models.election = new ElectionModel()
  
  # backbone views
  app.views.electionsIndex = new ElectionsIndexView({el: "#index"})
  app.views.electionsShow = new ElectionsShowView()
  
  # backbone app
  app.initialize = ->
    app.controllers.application = new ApplicationController()
    app.controllers.application.navigate("elections")
    
  app.initialize()
  Backbone.history.start()