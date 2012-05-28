class window.PropositionEmbedView extends Backbone.View

  className: =>
    if @model.isVideo()
      return "proposition-video"
    if @model.isDataviz()
      return "proposition-dataviz"
    else
      return "proposition-link"

  initialize: ->

    switch @model.type()
      when 'video' then switch @model.get('provider_name')
        when 'YouTube'
          @view = new PropositionEmbedYoutubeView(el: @el, model: @model)
      when 'dataviz' then switch @model.get('provider_name')
        when 'qunb'
          @view = new PropositionEmbedQunbView(el: @el, model: @model)
      when 'link'
        @view = new PropositionEmbedLinkView(el: @el, model: @model)

  render: ->
    @view.render()

    @
