class window.ElectionThemesCollection extends Backbone.Collection
  
  url: ->
    "/api/v1/elections/#{election.id}/addtheme"
    
  