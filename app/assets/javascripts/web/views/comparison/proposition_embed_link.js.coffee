class window.PropositionEmbedLinkView extends Backbone.View
  render: ->
    $(@el).html Mustache.to_html($('#proposition-embed-link-template').html(), embed: @model.toJSON())
    @