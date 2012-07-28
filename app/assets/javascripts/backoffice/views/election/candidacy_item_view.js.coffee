class Backoffice.Views.Election.CandidacyItemView extends Backbone.View
  tagName: 'tr'
  template: JST['backoffice/templates/election/candidacy_item']

  events: ->
    'click .toggle-publish': 'togglePublish'
    'change .change-picture': 'changePicture'

  initialize: ->
    @candidacy = @model
    @election = @options.election
    @candidacy.bind 'change', @render, @

  render: ->
    $(@el).html @template @

    @

  togglePublish: (event) ->
    @candidacy.save {}, data: $.param(candidacy: {published: (not @candidacy.get 'published')})

  changePicture: (event) ->
    image =  $('input[type=file]', @el)[0].files[0]
    @candidacy.candidates.first().addPhoto image
