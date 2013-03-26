class Admin.Views.Countries.CountriesView extends Backbone.View
  el: '.content'
  template: JST['admin/templates/countries/countries']

  events:
    'submit form.new-country': 'newCountry'

  initialize: ->
    @countries = @collection
    @countries.bind 'reset', @render, @
    @countries.bind 'add', @render, @

  render: ->
    $(@el).html @template @
    @

  newCountry: (event) ->
    event.preventDefault()
    form = $(event.target)
    country_name = $('[name=countryName]', form).val()
    country_namespace = country_name.replace /\s+/g, '-'
    country = new CountryModel(name: country_name, namespace: country_namespace)
    @countries.create(country, url: '/api/v1/countries/')
    @
