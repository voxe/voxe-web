class Backoffice.Views.Election.CandidaciesView extends Backbone.View
  template: JST['backoffice/templates/election/candidacies']

  events:
    'click .toggle-publish': 'togglePublish'

  initialize: ->
    @election = @model
    @candidacies = @election.candidacies
    self = @
    @candidacies.each (c) ->
      c.bind 'change', self.render, self
    @render()

  render: ->
    $(@el).html @template @
    $('button.hover', @el).hide()

  togglePublish: (event) ->
    candidacy_id = $(event.target).parent().parent().data().candidacyId
    candidacy = @candidacies.find (c) -> c.id == candidacy_id
    candidacy.save {}, data: $.param(candidacy: {published: (not candidacy.get 'published')})
