class Backoffice.Views.Election.Propositions.Candidacies.CandidaciesView extends Backbone.View
  template: JST['backoffice/templates/election/propositions/candidacies/layout']

  initialize: ->
    @election = @model
    @render()

  render: ->
    # render layout
    $(@el).html @template @model

    @election.candidacies.each @addCandidacy, @

    @

  addCandidacy: (candidacy) ->
    view = new Backoffice.Views.Election.Propositions.Candidacies.CandidacyView(model: candidacy, election: @election)
    viewEl = view.render().el
    $('table#candidacies', @el).append(viewEl)
