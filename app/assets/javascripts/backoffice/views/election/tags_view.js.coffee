class Backoffice.Views.Election.TagsView extends Backbone.View
  template: JST['backoffice/templates/election/tags']

  events:
    'submit form.add-tag': 'addOrCreateTag'
    'click .remove-tag': 'removeTag'

  initialize: ->
    @flash = {}
    @election = @options.election #readability++
    if @options.tag_id
      @tag = @options.election.tags.depthTagSearch @options.tag_id
      @tags = @tag.tags
    else
      @tags = @election.tags
    @tags.bind 'add', @render, @
    @election.bind 'error',
      (election) ->
        @flash.error_messages = election.error_messages
        @render()
      , @
    @render()

  render: ->
    $(@el).html @template @

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
