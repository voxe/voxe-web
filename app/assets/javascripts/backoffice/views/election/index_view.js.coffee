class Backoffice.Views.Election.IndexView extends Backbone.View
  template: JST['backoffice/templates/election/index']

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies
# 
#     @options.main_tag_id = "4ffc3357d5ded316c4000052"
#     @options.sub_tag_id = "4ffc3357d5ded316c4000054"
#     @options.sub_sub_tag_id = "4ffc3357d5ded316c4000068"
# 
#     @selectedMainTag = @mainTags.depthTagSearch @options.main_tag_id
#     
#     @subTags = @selectedMainTag.tags
#     @selectedSubTag = @mainTags.depthTagSearch @options.sub_tag_id
#     
#     @subSubTags = @selectedSubTag.tags
#     @selectedSubSubTag = @mainTags.depthTagSearch @options.sub_sub_tag_id
#     
#     @propositions = new PropositionsCollection()
#     @propositions.bind 'reset', @render, @
#     @propositions.fetch({data: {electionId: @election.id, candidacyIds: @candidacy.id, tagIds: @selectedSubSubTag.id}})
# 
    @render()

  updateCandidacy: (candidacy_id = "4ffc3358d5ded316c4000305") =>
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == candidacy_id), @
    @election.tags.each @addMainTag

  updateTag: (tag_id = "4ffc3357d5ded316c4000068") =>
    @election.tags.each @addMainTag
    @subTags.each @addSubTag
    @subSubTags.each @addSubSubTag
    @propositions.each @addProposition

  render: ->
    $(@el).html @template @
    @candidacies.each @addCandidacy
    @updateCandidacy()

  addCandidacy: (candidacy) =>
    view = new Backoffice.Views.Election.CandidacyItemView(election: @election, model: candidacy)
    viewEl = view.render().el
    $('.candidacies').append(viewEl)

  addMainTag: (tag) =>
    view = new Backoffice.Views.Election.TagItemView(election: @election, candidacy: @candidacy, model: tag)
    viewEl = view.render().el
    $('.main-tags').append(viewEl)

  addSubTag: (tag) =>
    view = new Backoffice.Views.Election.TagItemView(election: @election, candidacy: @candidacy, model: tag)
    viewEl = view.render().el
    $('.sub-tags').append(viewEl)

  addSubSubTag: (tag) =>
    view = new Backoffice.Views.Election.TagItemView(election: @election, candidacy: @candidacy, model: tag)
    viewEl = view.render().el
    $('.sub-sub-tags').append(viewEl)

  addProposition: (proposition) =>
    new Backoffice.Views.Election.Propositions.PropositionsList.PropositionsListView(
      el: '.propositions', election: @election,  candidacy_id: @candidacy.id, tag_id: @selectedSubSubTag.id)
