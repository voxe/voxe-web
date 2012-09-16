class window.CountryModel extends Backbone.Model
  
  # http://voxe.org/platform/models/country

  url: ->
    '/api/v1/countries'

  parse: (response) ->
    response.response.country
