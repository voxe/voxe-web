class Backoffice.Views.Election.TagsView extends Backbone.View
  template: JST['backoffice/templates/election/tags']

  events:
    'submit form.add-tag': 'addTag'

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
    $('form.add-tag .tag-name', @el).autocomplete
      source: (request, response) ->
        tags = new TagsCollection()
        tags.bind 'reset', ->
          response @map (tag) ->
            {label: tag.get('name'), value: tag.id}
        tags.search request.term
      select: (event, ui) ->
        $('.tag-name').val ui.item.label
        $('.tag-id').val ui.item.value
        return false
    @flash = {}

  addTag: (event) ->
    event.preventDefault()
    form = $(event.target)
    tag_id = $('.tag-id', form).val()
    if tag_id
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
