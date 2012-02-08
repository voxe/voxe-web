class Backoffice.Views.Election.CandidacyItemView extends Backbone.View
  tagName: 'tr'
  template: JST['backoffice/templates/election/candidacy_item']

  events: ->
    'click .toggle-publish': 'togglePublish'

  initialize: ->
    @candidacy = @model
    @candidacy.bind 'change', @render, @

  render: ->
    $(@el).html @template @

    @

  togglePublish: (event) ->
    @candidacy.save {}, data: $.param(candidacy: {published: (not @candidacy.get 'published')})
