class window.ElectionsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
    
  render: ->
    $(@el).html ''
    filtered = @collection.filterByCountry(@options.countryNamespace)
    _.each filtered, (election) =>
      view = new ElectionCellView model: election
      $(@el).append view.render().el
    @
