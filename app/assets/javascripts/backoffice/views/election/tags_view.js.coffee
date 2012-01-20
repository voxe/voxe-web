class Backoffice.Views.Election.TagsView extends Backbone.View
  template: JST['backoffice/templates/election/tags']

  events:
    'submit form.add-tag': 'addOrCreateTag'
    'click .remove-tag': 'removeTag'
    'click .start-rename-tag': 'startRenameTag'
    'submit .rename-tag-form': 'submitRenameTag'
    'click .cancel-rename-tag': 'cancelRenameTag'

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

    $('.tag-name input').hide()
    $('.cancel-rename-tag').hide()
    $('.finish-rename-tag').hide()

    # autocomplete
    form = $('form.add-tag', @el)
    $('.tag-name', form).keyup ->
      $('.tag-id', form).val('')
      $('input[type=submit]', form).val('Créer')
    $('.tag-name', form).autocomplete
      source: (request, response) ->
        tags = new TagsCollection()
        tags.bind 'reset', ->
          response @map (tag) ->
            {label: tag.get('name'), value: tag.id}
        tags.search request.term
      select: (event, ui) ->
        $('.tag-name').val ui.item.label
        $('.tag-id').val ui.item.value
        $('input[type=submit]', form).val('Ajouter')
        return false
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
      tag_name = tag_id = $('.tag-name', form).val()
      tag = new TagModel()
      tag.bind 'error',
        (tag, response) ->
          @flash.error_messages = tag.error_messages
          @render()
        @
      election = @election
      parent_tag = @tag if @tag
      tag.save {name: tag_name},
        success: (tag) -> # link tag to election
          if parent_tag?
            election.addTag tag, parent_tag
          else
            election.addTag tag

  removeTag: (event) ->
    tagId = $(event.target).parent().parent().data().tagId
    tag = @tags.find (t) -> t.id == tagId
    @election.removeTag tag

  startRenameTag: (event) ->
    tableLine = $(event.target).parent().parent()
    tagId = $(event.target).parent().parent().data().tagId
    tag = @tags.find (t) -> t.id == tagId

    field = $('.tag-name input', tableLine)
    field.val(tag.get 'name')

    $('.tag-name a', tableLine).hide()
    $('.start-rename-tag', tableLine).hide()
    $('.cancel-rename-tag', tableLine).show()
    $('.tag-name input', tableLine).show()
    $('.finish-rename-tag').show()

  submitRenameTag: (event) ->
    event.preventDefault()

    tableLine = $(event.target).parent()
    tagId = tableLine.data().tagId
    tag = @tags.find (t) -> t.id == tagId

    tagName = $('.tag-name input', tableLine).val()
    tag.save {}, data: $.param(tag: name: tagName)

  cancelRenameTag: (event) ->
    tableLine = $(event.target).parent().parent()
    $('.cancel-rename-tag', tableLine).hide()
    $('.tag-name input', tableLine).hide()
    $('.finish-rename-tag').hide()
    $('.tag-name a', tableLine).show()
    $('.start-rename-tag', tableLine).show()
