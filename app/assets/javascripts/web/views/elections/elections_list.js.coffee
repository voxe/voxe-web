class window.ElectionsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
    
  render: ->
    @collection.each (election) =>
      if election.attributes.country.namespace == @options.countryNamespace
        view = new ElectionCellView model: election
        $(@el).append view.render().el
    @
