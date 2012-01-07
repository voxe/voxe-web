class Backoffice.Views.Election.PropositionsCandidacyTagsView extends Backbone.View
  template: JST['backoffice/templates/election/propositions_candidacy_tags']

  initialize: ->
    @election = @options.election
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tags = @election.tags
    @render()

  render: ->
    $(@el).html @template @

