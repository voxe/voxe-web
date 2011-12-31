class Backoffice.Views.Election.TagsView extends Backbone.View
  template: JST['backoffice/templates/election/tags']

  initialize: ->
    @election = @model #readability++
    @tags = @election.tags
    @render()

  render: ->
    $(@el).html @template @
