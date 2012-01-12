class window.ElectionsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
  
  events:
    "click li": "clickElection"
    
  clickElection: (e)->
    li = $(e.target).closest('li')
    electionId = $(li).attr("election-id")
    election = @collection.get(electionId).toJSON()
    app.router.navigate election.namespace, true
    
  render: ->
    $(@el).html Mustache.to_html($('#elections-list-template').html(), elections: @collection.toJSON())
    new iScroll $('.table-view-container', @el).get(0)
    setTimeout hideURLbar, 0