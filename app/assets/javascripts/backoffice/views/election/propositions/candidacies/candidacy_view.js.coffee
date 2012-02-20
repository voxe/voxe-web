class Backoffice.Views.Election.Propositions.Candidacies.CandidacyView extends Backbone.View
  tagName: 'tr'

  template: JST['backoffice/templates/election/propositions/candidacies/candidacy']

  initialize: ->
    @election = @options.election
    @render()

  render: ->
    $(@el).html @template election: @election, candidacy: @model

    @
