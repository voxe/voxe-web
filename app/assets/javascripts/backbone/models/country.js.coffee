class window.CountryModel extends Backbone.Model
  url: -> "/api/v1/countries/#{@id}"
