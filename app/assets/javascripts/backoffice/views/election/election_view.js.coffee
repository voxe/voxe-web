class Backoffice.Views.ElectionView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/election/layout']

  initialize: (election_id, menu_entry) ->
    @election = new ElectionModel(id: election_id)
    @menu_entry = menu_entry
    @election.bind 'change', @render, @
    @election.fetch()

  render: ->
    $(@el).html @template @
    new Backoffice.Views.Election.ElectionMenuView(model: @election, menu_entry: @menu_entry)
    switch @menu_entry
      when 'contributors' then new Backoffice.Views.Election.ContributorsView(model: @election)

