class Backoffice.Views.CountriesView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/countries']

  initialize: ->
    @countries = new CountriesCollection()
    @countries.bind 'change', @render, @
    @countries.fetch()

  render: ->
    $(@el).html @template()

