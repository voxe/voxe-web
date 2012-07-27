class Backoffice.Views.Election.IndexView extends Backbone.View
  template: JST['backoffice/templates/election/index']

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies

    @options.candidacy_id = "4ffc3358d5ded316c4000305"
    @options.tag_id = "4ffc3357d5ded316c4000052"
    
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tag = @election.tags.depthTagSearch @options.tag_id
    @tags = @tag.tags

    @propositions = new PropositionsCollection()
    @propositions.bind 'reset', @render, @
    @propositions.fetch({data: {electionId: @election.id, candidacyIds: @candidacy.id, tagIds: @tag.id}})

    @render()

  render: ->
    $(@el).html @template @
    @candidacies.each @addCandidacy

  addCandidacy: (candidacy) ->
    view = new Backoffice.Views.Election.CandidacyItemView(model: candidacy)
    viewEl = view.render().el
    $('.candidacies').append(viewEl)
