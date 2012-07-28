class Backoffice.Views.Election.TagItemView extends Backbone.View
  template: JST['backoffice/templates/election/tag_item']
  tagName: 'tr'

  initialize: ->
    $(@el).attr "data-tag-id", @model.id
    @tag = @model
    @election = @options.election
    @candidacy = @options.candidacy
    @tag.bind 'change', @render, @

  render: ->
    $(@el).html @template @

    @

