class Platform.Views.EmbedFormView extends Backbone.View
  templates:
    electionSelector: JST['platform/templates/embed_election_selector']
    tagFilter: JST['platform/templates/embed_tag_filter']
    candidacyFilter: JST['platform/templates/embed_candidacy_filter']
    defaultTag: JST['platform/templates/embed_default_tag']
    defaultCandidacies: JST['platform/templates/embed_default_candidacies']
    preview: JST['platform/templates/embed_preview']

  events:
    'change [name="electionId"]': 'renderFilters'
    'change': 'renderPreview'
    'click .output': 'selectOutput'

  initialize: ->
    @collection = new ElectionsCollection()
    @collection.bind 'reset', @render, @
    @collection.fetch()

  render: ->
    @$('#election-list').html @templates.electionSelector(elections: @collection.toJSON())

  renderFilters: (event) ->
    electionId = $('input:radio[name=electionId]:checked').val()
    @election = @collection.find((e) -> electionId == e.id)

    @$('#tag-filter').html @templates.tagFilter(@election.toJSON())
    @$('#candidacy-filter').html @templates.candidacyFilter(@election.toJSON())
    @$('#default-tags').html @templates.defaultTag(@election.toJSON())
    @$('#default-candidacies').html @templates.defaultCandidacies(@election.toJSON())

  renderPreview: ->
    params = {}

    pushFilterAndDefaultToParams = (inputName, options={}) ->
      domItems = @$("input[name=#{inputName}]")
      seletedDomItems = @$("input[name=#{inputName}]:checked")
      if (options.anyByDefault and seletedDomItems.length isnt 0) or (not options.anyByDefault and seletedDomItems.length isnt domItems.length)
        console.log "#{seletedDomItems.length} vs #{domItems.length}"
        # map dom item to values and join
        params[inputName] = _.map(seletedDomItems, (c) -> $(c).val()).join(',')

    # hash to queryString
    pushFilterAndDefaultToParams 'tagIds'
    pushFilterAndDefaultToParams 'candidacyIds'
    pushFilterAndDefaultToParams 'defaultTagId', anyByDefault: true
    pushFilterAndDefaultToParams 'defaultCandidacyIds', anyByDefault: true
    params = $.param params if params

    iframeCode = "<iframe frameborder='0' width='600px' height='570px' src='http://voxe.org/embed/elections/#{@election.id}#{if _.isEmpty(params) then "" else "?#{params}"}'></iframe>"

    @$('#preview').html @templates.preview(iframeCode: iframeCode)

  selectOutput: (event) ->
    event.target.focus()
    event.target.select()
