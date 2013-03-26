class Admin.Views.Election.ContributorsView extends Backbone.View
  template: JST['admin/templates/election/contributors']

  initialize: ->
    @render()

  render: ->
    $(@el).html @template @
