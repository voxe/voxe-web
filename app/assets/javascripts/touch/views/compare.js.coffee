class window.CompareView extends Backbone.View

  theme: ->
    app.models.theme
    
  initialize: ->
    app.models.theme.bind "change", @changeTheme, @
    
  events:
    "click a.button": "themesClick"
    
  themesClick: ->
    app.router.themesList()
    
  changeTheme: ->
    $(".title", @el).html @theme().name()
    
  render: ->
    $(@el).html Mustache.to_html($('#compare-template').html(), theme: @theme())