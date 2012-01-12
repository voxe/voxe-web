class window.TagsListView extends Backbone.View
  
  tags: ->
    app.collections.tags.toJSON()
    
  election: ->
    app.models.election
  
  initialize: ->
    @election().bind "change", @render, @
    @last = null
  
  events:
    "click li": "themeClick"
      
  themeClick: (e)->
    tagId = $(e.currentTarget).attr("tag-id")
    if (tagId != @last)
      $('#propositions').hide()
      $('li div', @el).slideUp(200)
      @last = tagId
      $('div', e.currentTarget).slideToggle(200)
      tag = _.find app.models.election.tags.models, (tag) ->
        tag.id == tagId
      app.models.tag.set tag
    
  render: ->
    $(@el).html Mustache.to_html($('#tags-list-template').html().replace('&gt;', '>'), tags: @tags(), {"subtags": $('#subtags-list-template').html()})