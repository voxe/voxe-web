class Backoffice.Views.ElectionsView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/elections']

  initialize: ->
    @elections = new ElectionsCollection()
    @elections.bind 'reset', @render, @
    @elections.fetch()

  render: ->
    $(@el).html @template @
