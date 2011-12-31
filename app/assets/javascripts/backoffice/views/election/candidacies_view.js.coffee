class Backoffice.Views.Election.CandidaciesView extends Backbone.View
  template: JST['backoffice/templates/election/candidacies']

  initialize: ->
    @election = @model
    @candidacies = @election.candidacies
    @render()

  render: ->
    $(@el).html @template @
