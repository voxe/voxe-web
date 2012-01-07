class Backoffice.Views.Election.TagsView extends Backbone.View
  template: JST['backoffice/templates/election/tags']

  initialize: ->
    @election = @options.election #readability++
    if @options.tag_id
      @tag = @options.election.tags.search_tag @options.tag_id
      @tags = @tag.tags
    else
      @tags = @election.tags
    @render()

  render: ->
    $(@el).html @template @
