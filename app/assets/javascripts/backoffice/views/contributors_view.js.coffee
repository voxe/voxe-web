class Backoffice.Views.Election.ContributorsView extends Backbone.View
  el: '.election-content'
  template: JST['backoffice/templates/election/contributors']

  initialize: ->
    @render()

  render: ->
    $(@el).html @template @
