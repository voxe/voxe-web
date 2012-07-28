class Backoffice.Views.Election.IndexView extends Backbone.View
  template: JST['backoffice/templates/election/index']

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies

    if @options.tag_id
      @propositions = new PropositionsCollection()
      @propositions.bind 'reset', @render, @
      @propositions.fetch {data: {electionId: @election.id, candidacyIds: @options.candidacy_id, tagIds: @options.tag_id}}
    else
      @render()

  updateCandidacy: (candidacy_id) =>
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @election.tags.each @addMainTag

  updateTag: (tag_id) =>
    @election.tags.each @addMainTag
    @tag = @election.tags.depthTagSearch(@options.tag_id)
    if @tag.collection.parent_tag
      if @tag.collection.parent_tag.collection.parent_tag
        @tag.collection.parent_tag.collection.each @addSubTag
        @tag.collection.each @addSubSubTag
      else
        @tag.collection.each @addSubTag
        @tag.tags.each @addSubSubTag
    else
      @tag.tags.each @addSubTag
      
  render: ->
    $(@el).html @template @
    @candidacies.each @addCandidacy
    @updateCandidacy() if @options.candidacy_id
    @updateTag() if @options.tag_id
    @propositions.each @addProposition if @propositions

  addCandidacy: (candidacy) =>
    view = new Backoffice.Views.Election.CandidacyItemView(election: @election, model: candidacy)
    viewEl = view.render().el
    $('.candidacies').append(viewEl)

  addMainTag: (tag) =>
    @addTag tag, $('.main-tags')

  addSubTag: (tag) =>
    @addTag tag, $('.sub-tags')

  addSubSubTag: (tag) =>
    @addTag tag, $('.sub-sub-tags')

  addTag: (tag, target) =>
    view = new Backoffice.Views.Election.TagItemView(election: @election, candidacy: @candidacy, model: tag)
    viewEl = view.render().el
    target.append(viewEl)

  addProposition: (proposition) =>
    new Backoffice.Views.Election.Propositions.PropositionsList.PropositionsListView(
      el: '.propositions', election: @election,  candidacy_id: @candidacy.id, tag_id: @options.tag_id)
