# ROUTER

class window.AppRouter
  
  candidatesList: ->
    app.views.application.presentModalView 'candidacies-list'
    
  themesList: ->
    app.views.navigation.push 'tags'
    
  compareView: ->
    app.views.navigation.push 'compare'
    
  share: ->
    app.views.application.presentModalView 'share'