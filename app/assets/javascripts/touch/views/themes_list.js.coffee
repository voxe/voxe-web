class window.ThemesListView extends Backbone.View
  
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
    @election().fetch()
  
  events:
    "click ul.themes li": "themeClick"
      
  themeClick: (e)->
    li = $(e.target).closest('li')
    themeId = li.attr("theme-id")
    theme = _.find app.models.election.themes(), (theme) ->
      theme.id == themeId    
    app.models.theme.set theme
    
    app.router.propositionsView()
    
  render: ->
    $(@el).html Mustache.to_html($('#themes-list-template').html(), election: @election())
    # new iScroll $('.table-view-container', @el).get(0)