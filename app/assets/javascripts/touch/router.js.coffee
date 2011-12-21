# ROUTER

class window.AppRouter
  
  candidatesList: ->
    app.views.application.presentModalView()
    
  themesList: ->
    app.views.navigation.push 'tags'
    
  compareView: ->
    app.views.navigation.push 'compare'