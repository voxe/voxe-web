class window.TagsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
    $(@el).hover @mouseEnter, @mouseLeave
    
    $(@el).css 'left', "#{app.views.application.width - 250}px"
  
  events:
    "click ul li": "tagClick"
      
  tagClick: (e)->
    @.$('li').removeClass 'selected'
    $li = $(e.target).closest('li')
    $li.addClass 'selected'
    
    tagId = $li.attr("tag-id")
    tag = _.find app.models.election.tags.toJSON(), (tag) ->
      tag.id == tagId
    app.models.tag.set tag
    
  mouseEnter: =>
    if $('#app').attr 'compare'
      @hover = true
      setTimeout @move, 200
      
  move: =>
    if @hover
      $('#tags-list').animate {left: "#{app.views.application.width - 250}px"}, 600
      $('#propositions').animate {left: "-130px"}, 600
    
  mouseLeave: =>
    @hover = false
    if $('#app').attr 'compare'
      $('#tags-list').animate {left: "#{app.views.application.width - 49}px"}, 600
      $('#propositions').animate {left: "49px"}, 600
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html(), tags: @collection.toJSON())

    # trigger a click on default tag
    if(@options.defaultTagId)
      defaultTagId = @options.defaultTagId
      defaultTagListItem = _.find @$('li'), (listItem) ->
        listItem.getAttribute('tag-id') == defaultTagId
      $(defaultTagListItem).click()
      @options.defaultTagId = null

    @
