class Backoffice.Views.ElectionsView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/elections']

  events:
    'submit form.new-election': 'newElection'

  initialize: ->
    @elections = new ElectionsCollection()
    @elections.bind 'reset', @render, @
    @elections.bind 'add', @render, @
    @elections.fetch({data: published: 'all'})
    @flash = {}

  render: ->
    $(@el).html @template @
    @flash = {}

  newElection: (event) ->
    event.preventDefault()
    form = $(event.target)
    election_name = $('[name=electionName]', form).val()
    election_namespace = election_name.replace /\s+/g, '-'
    election = new ElectionModel(name: election_name, namespace: election_namespace)
    election.bind 'error',
      (election, response) ->
        @flash.error_messages = election.error_messages
        @render()
      @

    @elections.create(election, url: '/api/v1/elections/')
