# ROUTER

class window.AppRouter
  
  candidatesList: ->
    app.views.application.presentModalView()
    
  themesList: ->
    app.views.navigation.push 'themes'
    
  propositionsView: ->
    app.views.navigation.push 'propositions'
    app.views.propositions.show()