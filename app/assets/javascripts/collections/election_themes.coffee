class window.ElectionThemesCollection extends Backbone.Collection
  
  addTheme: (name) ->
    alert name
  
  url: ->
    "/api/v1/elections/#{election.id}/addtheme"
    
  