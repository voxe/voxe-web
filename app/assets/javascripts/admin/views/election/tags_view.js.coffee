class Admin.Views.Election.TagsView extends Backbone.View
  template: JST['admin/templates/election/tags']

  events:
    'submit .add-tag': 'addOrCreateTag'

  initialize: ->
    @flash = {}
    @election = @options.election #readability++
    if @options.tag_id
      @tag = @options.election.tags.depthTagSearch @options.tag_id
      @tags = @tag.tags
    else
      @tags = @election.tags
    @tags.bind 'add', @render, @
    @tags.bind 'change', @render, @
    @election.bind 'error',
      (election) ->
        @flash.error_messages = election.error_messages
        @render()
      , @
    @render()

  render: ->
    $(@el).html @template @

    form = $('form.add-tag', @el)

    # define helper
    setTagId = (id) ->
      $('.tag-id').val(id)
      if $('.tag-id').val() == ""
        $('input[type=submit]', form).val('Créer')
      else
        $('input[type=submit]', form).val('Ajouter')

    # unset tag id if field is empty
    $('.tag-name', form).keyup (event) -> setTagId '' if event.target.value == ''

    # autocomplete
    $('.tag-name', form).autocomplete
      source: (request, response) ->
        tags = new TagsCollection()
        tags.bind 'reset', ->
          exactTag = (@find (t) -> t.get('name') == request.term)
          if exactTag
            setTagId exactTag.id
          else
            setTagId ''
          response @map (tag) ->
            {label: tag.get('name'), value: tag.id}
        tags.search request.term
      select: (event, ui) ->
        $('.tag-name').val ui.item.label
        setTagId ui.item.value
        return false
      focus: (event, ui) ->
        $('.tag-name').val ui.item.label
        return false

    election = @election
    $('.tags', @el).tableDnD
      onDrop: (table, row) ->
        ids = _.map $('tr', table), (ro) ->
          $(ro).data().tagId
        election.moveTags(ids)

    @flash = {}

  addOrCreateTag: (event) ->
    event.preventDefault()
    form = $(event.target)
    tag_id = $('.tag-id', form).val()
    if tag_id # add
      $('.btn', form).button('loading')
      tag = new TagModel(id: tag_id)
      tag.bind 'change',
        (tag) ->
          if @tag #parent_tag
            @election.addTag tag, @tag
          else
            @election.addTag tag
        @
      tag.fetch()
    else # create
      tagName = tag_id = $('.tag-name', form).val()
      tag = new TagModel()
      election = @election
      parent_tag = @tag if @tag
      tagNamespace = tagName.replace /\s+/g, '-'
      view = @
      tag.bind 'error', (tag, response) ->
        view.flash.error_messages = tag.error_messages
        view.render()
      tag.save {name: tagName, namespace: tagNamespace},
        success: (tag) -> # link tag to election
          if parent_tag?
            election.addTag tag, parent_tag
          else
            election.addTag tag
