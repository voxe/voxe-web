class window.ComparisonTagView extends Backbone.View

  initialize: (options) ->
    @tag          = options.tag
    @candidacies  = options.candidacies
    @propositions = options.propositions

  render: ->
    # render section (tag)
    $(@el).html Mustache.to_html($('#comparison-tag-template').html(), tag: @tag.toJSON())

    # render categories (tag.tags)
    if @tag.tags.length == 0
      view = new ComparisonCandidaciesView(candidacies: @candidacies, propositions: @propositions[@tag.id])
      $(@el).append view.render().el
    else
      _.each @tag.tags.models, (tag) =>
        $(@el).append Mustache.to_html($('#comparison-tag-template').html(), tag: tag.toJSON())

        # render candidacies (w/ propositions)
        view = new ComparisonCandidaciesView(candidacies: @candidacies, propositions: @propositions[tag.id])
        $(@el).append view.render().el

    @
