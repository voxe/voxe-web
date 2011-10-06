class window.ElectionsShowThemeView extends Backbone.View
  
  className: 'candidate'
    
  initialize: ->
    _.bindAll this, 'render'
    @model.bind 'change', @render

  render: ->
    $(@el).html JST["elections/show/theme"](@model.toJSON())
    @