class window.ComparisonCandidacyView extends Backbone.View
  
  initialize: (options) ->
    @candidacy    = options.candidacy
    @propositions = options.propositions
  
  render: ->
    # render candidacy
    $(@el).html Mustache.to_html($('#comparison-candidacy-template').html(), candidacy: @candidacy.toJSON())

    if @propositions and @propositions.length > 0
      # render propositions
      _.each @propositions, (proposition) =>
        view = new ComparisonPropositionView(model: proposition)
        $(@el).append view.render().el
    else
      $(@el).append $('#no-proposition-available-template').html()
    
    # returns this
    @
