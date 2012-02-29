class window.PropositionEmbedLinksView extends Backbone.View
  
  className: "proposition-links"

  render: ->
    $(@el).html Mustache.to_html $('#proposition-embed-links-template').html()
    
    _.each  @collection.models, (link) =>
      view = new PropositionEmbedView model: link
      $(@el).append view.render().el
    @