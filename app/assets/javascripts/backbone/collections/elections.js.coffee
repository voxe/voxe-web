class window.ElectionsCollection extends Backbone.Collection
  model: ElectionModel

  url: '/api/v1/elections/search'

  parse: (response) ->
    response.response.elections
