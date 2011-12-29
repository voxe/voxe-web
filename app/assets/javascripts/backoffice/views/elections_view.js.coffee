class Backoffice.Views.ElectionsView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/elections']

  initialize: ->
    @elections = new ElectionsCollection()
    @elections.bind 'change', @render, @
    @elections.fetch(url: '/api/v1/elections')

  render: ->
    $(@el).html @template()
