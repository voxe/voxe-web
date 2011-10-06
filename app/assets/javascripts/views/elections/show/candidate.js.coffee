class window.ElectionsShowCandidateView extends Backbone.View
  
  className: 'candidate'
    
  initialize: ->
    _.bindAll this, 'render'
    @model.bind 'change', @render

  render: ->
    $(@el).html JST["elections/show/candidate"](@model.toJSON())
    @