class window.CountriesListView extends Backbone.View
  
  initialize: ->
    @collection.bind "reset", @render, @
    
  render: ->
    previous = []
    upcoming = []
    now = new Date
    @collection.each (election) =>
      if election.date() > now
        upcoming.push(election.attributes.country)
      else
        previous.push(election.attributes.country)

    rendered = []

    _.each upcoming, (country) =>
      if country and _.indexOf(rendered, country.namespace) == -1
        view = new CountryCellView model: country
        $(@el).find("#countries-upcoming-list").prepend view.render().el
        rendered.push country.namespace
    _.each previous, (country) =>
      if country and _.indexOf(rendered, country.namespace) == -1
        view = new CountryCellView model: country
        $(@el).find("#countries-previous-list").prepend view.render().el
        rendered.push country.namespace

    @
