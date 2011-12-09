class window.ThemesListView extends Backbone.View
  
  events:
    "click ul.themes li": "themeClick"
      
  themeClick: (e)->
    li = $(e.target).closest('li')
    themeId = li.attr("theme-id")
    # theme = _.find app.models.election.get('themes'), (theme) ->
    #   theme.id == themeId
    # app.models.themeSelected = new ThemeModel(theme)
    
    app.router.navigate "propositions", true