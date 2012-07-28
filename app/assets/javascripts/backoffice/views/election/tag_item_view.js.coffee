class Backoffice.Views.Election.TagItemView extends Backbone.View
  template: JST['backoffice/templates/election/tag_item']

  initialize: ->
    @tag = @model
    @election = @options.election
    @candidacy = @options.candidacy
    @tag.bind 'change', @render, @

  render: ->
    $(@el).html @template @

    @

