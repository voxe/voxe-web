class Backoffice.Views.Election.Propositions.Tags.TagsView extends Backbone.View
  template: JST['backoffice/templates/election/propositions/tags/tags']

  initialize: ->
    @election = @options.election
    @candidacy = @election.candidacies.find ((candidacy) -> candidacy.id == @options.candidacy_id), @
    @tags = @election.tags
    @render()

  render: ->
    $(@el).html @template @candidacy

    @election.tags.each @addTag, @

    @

  addTag: (tag) ->
    view = new Backoffice.Views.Election.Propositions.Tags.TagView(model: tag, candidacy: @candidacy, election: @election)
    viewEl = view.render().el
    $('table#tags', @el).append(viewEl)
