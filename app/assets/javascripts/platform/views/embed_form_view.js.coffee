class Platform.Views.EmbedFormView extends Backbone.View
  templates:
    electionItem: JST['platform/templates/embed_election_item']
    tagItem: JST['platform/templates/embed_tag_item']
    preview: JST['platform/templates/embed_preview']

  events:
    'change [name="electionId"]': 'renderTagList'
    'change': 'renderPreview'
    'click .output': 'selectOutput'

  initialize: ->
    @collection = new ElectionsCollection()
    @collection.bind 'reset', @render, @
    @collection.fetch()

  render: ->
    @$('#election-list').html @templates.electionItem(elections: @collection.toJSON())

  renderTagList: (event) ->
    electionId = $('input:radio[name=electionId]:checked').val()
    @election = @collection.find((e) -> electionId == e.id)

    @$('#tag-list').html @templates.tagItem(@election.toJSON())

  renderPreview: ->
    checkedTagCheckBoxes = $('input:checkbox[name=tagIds]:checked')
    unless checkedTagCheckBoxes.length == @election.tags.length
      tagIds = _.map checkedTagCheckBoxes, (c) -> $(c).val()

    params = ""
    params += "/?tagIds=#{tagIds.join(',')}" if tagIds

    iframeCode = "<iframe frameborder='0' width='600px' height='570px' src='http://voxe.org/embed/elections/#{@election.id}#{params}'></iframe>"

    @$('#preview').html @templates.preview(iframeCode: iframeCode)

  selectOutput: (event) ->
    event.target.focus()
    event.target.select()
