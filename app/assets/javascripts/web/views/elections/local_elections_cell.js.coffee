class @LocalElectionsView extends Backbone.View
  events:
    'change input': -> app.router.navigate @$('input').val(), true

  initialize: ->
    $(@el).html Mustache.to_html($('#local-elections-cell-template').html())
    @$('input').select2(
      width: '300px'
      query: (query) =>
        $.getJSON '/api/v1/elections/search',
          name: query.term
          parent: @model.get('id')
          (r) ->
            query.callback results: _.map(r.response.elections, (c) -> { id: c.namespace, text: c.name })
    )
