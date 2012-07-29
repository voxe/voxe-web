class Backoffice.Views.Election.IndexView extends Backbone.View
  template: JST['backoffice/templates/election/index']

  events: ->
    "click .tags a": "tagClicked"

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies

    if @options.tagId
      @tag = @election.tags.depthTagSearch(@options.tagId)
      @updatePropositions()
      
    @render()

  updatePropositions: =>
    $('.propositions').html 'loading...'
    @propositions = new PropositionsCollection()
    @propositions.bind 'reset', @renderPropositions, @
    @propositions.fetch {data: {electionId: @election.id, candidacyIds: @options.candidacyId, tagIds: @tag.id}}

  updateCandidacy: (candidacyId) =>
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacyId), @
    $('.candidacies').removeClass "selected"
    $("[data-candidacy-id=#{@candidacy.id}]").addClass "selected"

  updateTag: (init = true) =>
    $('.sub-sub-tags').html ''
    if @tag.collection.parent_tag
      if @tag.collection.parent_tag.collection.parent_tag
        @tag.collection.parent_tag.collection.each @addSubTag if init
        @tag.collection.each @addSubSubTag
      else
        $('.sub-tags').html ''
        @tag.collection.each @addSubTag
        @tag.tags.each @addSubSubTag
    else
      $('.main-tags tr').removeClass 'selected'
      $('.sub-tags').html ''
      @tag.tags.each @addSubTag
    $("[data-tag-id=#{@tag.id}]").addClass "selected"
      
  render: ->
    $(@el).html @template @
    @candidaciesView = new Backoffice.Views.Election.CandidaciesView(el: '.candidacies', model: @election)
    @updateCandidacy() if @options.candidacyId
    @election.tags.each @addMainTag if @candidacy
    @updateTag() if @tag
    
  renderPropositions: =>
    @propositions.each @addProposition if @propositions

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
      el: '.propositions', election: @election,  candidacy_id: @candidacy.id, tag_id: @tag.id)

  tagClicked: (event) =>
    event.preventDefault()
    tagId = $(event.currentTarget).closest('tr').data('tag-id')
    @tag = @election.tags.depthTagSearch(tagId)
    Backbone.history.navigate "elections/#{@election.id}/propositions/candidacies/#{@candidacy.id}/tags/#{@tag.id}"
    @updateTag false
    @updatePropositions()
