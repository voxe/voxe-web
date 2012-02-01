class Backoffice.Views.Elections.ElectionItemView extends Backbone.View
  tagName: 'tr'

  template: JST['backoffice/templates/elections/election_item']

  events:
    'click .toggle-publish': 'togglePublish'

  initialize: ->
    @election = @model
    @election.bind 'change', @render, @

  render: ->
    $(@el).html @template @
    @

  togglePublish: ->
    @election.togglePublish()
