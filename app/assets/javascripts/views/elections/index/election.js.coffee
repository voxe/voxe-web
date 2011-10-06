class window.ElectionsIndexElectionView extends Backbone.View
  
  className: 'election'
    
  initialize: ->
    _.bindAll this, 'render'
    @model.bind 'change', @render

  render: ->
    $(@el).html JST["elections/index/election"](@model.toJSON())
    @