class window.ElectionsListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
    
  render: ->
    $(@el).html ''
    filtered = @collection.filterByCountry(@options.countryNamespace)
    _.each filtered, (election) =>
      console.log election.get('namespace')
      if election.get('namespace') == 'election-municipales-2014'
        view = new LocalElectionsView model: election
      else
        view = new ElectionCellView model: election
      $(@el).append view.render().el
    @
