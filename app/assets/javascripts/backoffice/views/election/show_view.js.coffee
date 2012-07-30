class Backoffice.Views.Election.ShowView extends Backbone.View
  template: JST['backoffice/templates/election/show']

  events: ->
    "click .tags a.tag": "tagClicked"

  initialize: ->
    @flash = {}
    @election = @model
    @candidacies = @election.candidacies

    if @options.tagId
      @tag = @election.tags.depthTagSearch(@options.tagId)
      @updatePropositions()

    @render()
 
    $('.add-tag').submit (event) =>
      event.preventDefault()
      @addOrCreateTag event
 
    $('.tags-list .add button').click (event) =>
      event.preventDefault()
      @addATagClicked event

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
    $('.sub-sub-tags .tags').html ''
    if @tag.collection.parent_tag
      if @tag.collection.parent_tag.collection.parent_tag
        @tag.collection.parent_tag.collection.each @addSubTag if init
        @tag.collection.each @addSubSubTag
      else
        $('.sub-tags .tags').html ''
        @tag.collection.each @addSubTag
        @tag.tags.each @addSubSubTag
    else
      $('.main-tags tr').removeClass 'selected'
      $('.sub-tags .tags').html ''
      @tag.tags.each @addSubTag
    $("[data-tag-id=#{@tag.id}]").addClass "selected"
    @updateTagsButtonsVisibility()
  
  updateTagsButtonsVisibility: ->
    if $('.main-tags .tags').is(':empty')
      $('.main-tags .add').hide()
    else
      $('.main-tags .add').show()

    if $('.sub-tags .tags').is(':empty')
      $('.sub-tags .add').hide()
    else
      $('.sub-tags .add').show()

    if $('.sub-sub-tags .tags').is(':empty')
      $('.sub-sub-tags .add').hide()
    else
      $('.sub-sub-tags .add').show()
      
  render: ->
    $(@el).html @template @
    @candidaciesView = new Backoffice.Views.Election.CandidaciesView(el: '.candidacies', model: @election)
    @updateCandidacy() if @options.candidacyId
    @election.tags.each @addMainTag if @candidacy
    @updateTag() if @tag
    @updateTagsButtonsVisibility()

  renderPropositions: =>
    @propositions.each @addProposition if @propositions

  addMainTag: (tag) =>
    @addTag tag, $('.main-tags .tags')

  addSubTag: (tag) =>
    @addTag tag, $('.sub-tags .tags')

  addSubSubTag: (tag) =>
    @addTag tag, $('.sub-sub-tags .tags')

  addTag: (tag, target) =>
    view = new Backoffice.Views.Election.TagItemView(election: @election, candidacy: @candidacy, model: tag)
    viewEl = view.render().el
    target.append(viewEl)

  addProposition: (proposition) =>
    @propositionsListView = new Backoffice.Views.Election.Propositions.PropositionsList.PropositionsListView(
      el: '.propositions', election: @election,  candidacy_id: @candidacy.id, tag_id: @tag.id)

  tagClicked: (event) =>
    event.preventDefault()
    tagId = $(event.currentTarget).closest('tr').data('tag-id')
    @tag = @election.tags.depthTagSearch(tagId)
    Backbone.history.navigate "elections/#{@election.id}/propositions/candidacies/#{@candidacy.id}/tags/#{@tag.id}"
    @updateTag false
    @updatePropositions()

  addATagClicked: (event) =>
    @targetTagLevel =
      if $(event.target).hasClass('add-main-tag')
        "main"
      else if $(event.target).hasClass('add-sub-tag')
        "sub"
      else
        "sub-sub"

  addOrCreateTag: (event) =>
    event.preventDefault()
    
    parentTag =
      if @targetTagLevel == "sub"
        if @tag.parents().length == 2
          @tag.parents()[0]
        else if @tag.parents().length == 1
          @tag.parents()[0]
        else if @tag.parents().length == 0
          @tag
      else if @targetTagLevel == "sub-sub"
        if @tag.parents().length == 2
          @tag.parents()[1]
        else if @tag.parents().length == 1
          @tag

    form = $(event.target)
    tag_id = $('.tag-id', form).val()
    if tag_id # add
      $('.btn', form).button('loading')
      tag = new TagModel(id: tag_id)
      tag.bind 'change',
        (tag) ->
          if parentTag
            @election.addTag tag, parentTag
          else
            @election.addTag tag
        @
      tag.fetch()
    else # create
      tagName = tag_id = $('.tag-name', form).val()
      tag = new TagModel()
      election = @election
      tagNamespace = tagName.replace /\s+/g, '-'
      view = @
      tag.bind 'error', (tag, response) ->
        view.flash.error_messages = tag.error_messages
        view.render()
      tag.save {name: tagName, namespace: tagNamespace},
        success: (tag) => # link tag to election
          if parentTag?
            election.addTag tag, parentTag
            if @targetTagLevel == "sub"
              @addSubTag tag
            else if @targetTagLevel == "sub-sub"
              @addSubSubTag tag
          else
            election.addTag tag
            @addMainTag tag
          $('#modal-tags').modal('hide')
        error: (tag) =>
          console.log "error"
