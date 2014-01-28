class window.ComparisonCandidaciesView extends Backbone.View

  className: "candidacies"

  initialize: (options) ->
    @candidacies  = options.candidacies
    @propositions = options.propositions

  render: ->
    if @propositions?
      _.each @candidacies.models, (candidacy, index) =>
        propositions = @propositions[candidacy.id]
        view = new ComparisonCandidacyView(candidacy: candidacy, propositions: propositions, className: "candidacy #{['left', 'right'][index]}")
        $(@el).append view.render().el
    else
      $(@el).append $('#no-proposition-available-template').html()

    # returns this
    @
