class Backoffice.Views.Election.PropositionsCandidaciesView extends Backbone.View
  template: JST['backoffice/templates/election/propositions_candidacies']

  initialize: ->
    @election = @model
    #@propositions = new PropositionsCollection()
    #@propositions.bind 'reset', @render, @
    #@propositions.fetch({data: {electionId: @election.id}})
    @candidacies = @election.candidacies
    @render()

  render: ->
    $(@el).html @template @
