class Backoffice.Views.Election.ContributorsView extends Backbone.View
  template: JST['backoffice/templates/election/contributors']

  initialize: ->
    @render()

  render: ->
    $(@el).html @template @
