class window.ComparisonCandidaciesView extends Backbone.View
  
  className: "candidacies"
  
  initialize: (options) ->    
    @candidacies  = options.candidacies
    @propositions = options.propositions

  render: ->
    _.each @candidacies.models, (candidacy, index) =>
      if @propositions?
        propositions = @propositions[candidacy.id]
        view = new ComparisonCandidacyView(candidacy: candidacy, propositions: propositions, className: "candidacy #{['left', 'right'][index]}")
        $(@el).append view.render().el
    
    # returns this
    @