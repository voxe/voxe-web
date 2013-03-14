class Admin.Views.ElectionsView extends Backbone.View
  el: '.content'
  template: JST['admin/templates/elections']

  events:
    'submit form.new-election': 'newElection'

  initialize: ->
    @elections = @collection
    @elections.bind 'reset', @render, @
    @elections.bind 'add', @render, @
    @flash = {}

  render: ->
    $(@el).html @template @
    @elections.each @addElection
    @flash = {}
    @

  addElection: (election) ->
    view = new Admin.Views.Elections.ElectionItemView(model: election)
    viewEl = view.render().el
    $('table.elections').append(viewEl)

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
