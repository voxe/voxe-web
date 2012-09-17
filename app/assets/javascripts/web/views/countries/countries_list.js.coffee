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

    previous_rendered = []
    upcoming_rendered = []

    _.each previous, (country) =>
      if _.indexOf(previous_rendered, country.namespace) == -1
        view = new CountryCellView model: country
        $(@el).find("#countries-previous-list").prepend view.render().el
        previous_rendered.push country.namespace
    _.each upcoming, (country) =>
      if _.indexOf(upcoming_rendered, country.namespace) == -1
        view = new CountryCellView model: country
        $(@el).find("#countries-upcoming-list").prepend view.render().el
        upcoming_rendered.push country.namespace

    @
