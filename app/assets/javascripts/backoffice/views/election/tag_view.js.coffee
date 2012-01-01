class Backoffice.Views.Election.TagView extends Backbone.View
  template: JST['backoffice/templates/election/tag']

  initialize: ->
    @tag = @options.election.tags.search_tag @options.tag_id
    @election = @options.election
    @subtags = @tag.tags
    @render()

  render: ->
    $(@el).html @template @
