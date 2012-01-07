class Backoffice.Views.Election.PropositionsCandidacyTagView extends Backbone.View
  template: JST['backoffice/templates/election/propositions_candidacy_tag']

  initialize: ->
    @election = @options.election
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tag = @election.tags.search_tag @options.tag_id
    if @tag.tags.isEmpty()
      @propositions = new PropositionsCollection()
      @propositions.bind 'reset', @render, @
      @propositions.fetch({data: {electionId: @election.id, tagIds: @tag.id}})
    else
      @tags = @tag.tags
      @render()

  render: ->
    $(@el).html @template @


