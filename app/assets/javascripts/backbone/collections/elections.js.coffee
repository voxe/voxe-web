class window.ElectionsCollection extends Backbone.Collection
  
  model: ElectionModel

  url: '/api/v1/elections/search'

  parse: (response) ->
    response.response.elections

  comparator: (m) ->
    date = new Date(m.get('date') || null)
    current_date = new Date()

    return Math.abs(date - current_date)

  filterByCountry: (countryNamespace) ->
    filtered = _.filter @models, (election) =>
      election.attributes.country and election.attributes.country.namespace == countryNamespace
    proxy = @
    if _.any(filtered)
      proxy.selectedCountry = _.first(filtered).attributes.country
    @trigger "filter:country"
    filtered
