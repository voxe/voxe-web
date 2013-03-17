class Admin.Views.Election.InformationsView extends Backbone.View
  template: JST['admin/templates/election/informations']

  events:
    'submit form.general-informations': 'submitForm'

  initialize: ->
    @election = @model

    @election.bind 'change', @successfullyChanged, @

    @countries = new CountriesCollection()
    @countries.bind 'reset', @render, @
    @countries.fetch()

    @render()

  render: ->
    @$(@el).html @template @

  submitForm: (event) ->
    event.preventDefault()

    @election.save(
      date: @$('[name="election_date"]').val(),
      country_namespace: @$('[name="election_country"] option:selected').val()
    )

  successfullyChanged: ->
    @$(@el).prepend JST['admin/templates/success_message']({message: 'Nice !'})
