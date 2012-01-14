class window.CompareView extends Backbone.View
    
  initialize: ->
    @collection.bind "change:selected", @changeTag, @
    
  events:
    "click a.nav": "themesClick"
    "click a.share": "share"
    
  themesClick: ->
    app.router.navigate "#{app.models.election.namespace()}/#{app.models.election.candidacies.toParam()}", true
    
  share: ->
    app.router.share()
    
  changeTag: ->
    return unless @collection.selected()
    $(".title", @el).html @collection.selected().name()
    
  render: ->
    if @collection.selected()
      tag = @collection.selected().toJSON()
    else
      tag = null
    $(@el).html Mustache.to_html($('#compare-template').html(), tag: tag)