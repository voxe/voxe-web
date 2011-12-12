class window.ThemesListView extends Backbone.View
  
  events:
    "click ul.themes li": "themeClick"
      
  themeClick: (e)->
    li = $(e.target).closest('li')
    themeId = li.attr("theme-id")
    theme = _.find app.models.election.themes(), (theme) ->
      theme.id == themeId    
    app.models.theme.set theme
    
    app.router.propositionsView()