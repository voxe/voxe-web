# ROUTER

class window.AppRouter
  
  candidatesList: ->
    app.views.application.presentModalView()
    
  themesList: ->
    app.views.navigation.push 'themes'
    
  compareView: ->
    app.views.navigation.push 'compare'