class Backoffice.Views.Election.InformationsView extends Backbone.View
  template: JST['backoffice/templates/election/informations']

  events:
    'submit form.general-informations': 'submitForm'

  initialize: ->
    @election = @model

    @election.bind 'change', @successfullyChanged, @

    @render()

  render: ->
    @$(@el).html @template @

  submitForm: (event) ->
    event.preventDefault()

    @election.save(date: @$('[name="election_date"]').val())

  successfullyChanged: ->
    @$(@el).prepend JST['backoffice/templates/success_message']({message: 'Nice !'})
