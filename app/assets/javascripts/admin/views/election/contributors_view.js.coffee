class Admin.Views.Election.ContributorsView extends Backbone.View
  el: '#modal-contributors .modal-body'
  template: JST['admin/templates/election/contributors']

  events:
    'submit #contributor-form': 'addContributor'

  initialize: ->
    @election = @model
    @collection = @election.contributors()
    @collection.bind 'reset', @render, @
    @render()

  render: ->
    $(@el).html @template @

    #autocomplete
    form = $('#contributor-form', @el)
    $('.name', form).autocomplete
      source: (request, response) ->
        users = new UsersCollection()
        users.bind 'reset', ->
          response @map (user) ->
            {label: user.get('name'), value: user.id}
        users.fetch data: name: request.term
      focus: (event, ui) ->
        $('.name', form).val ui.item.label
        return false
      select: (event, ui) ->
        $('.name', form).val ui.item.label
        $('.id', form).val ui.item.value
        return false

  fetch_contributors: ->
    @collection.fetch()

  addContributor: (event) ->
    event.preventDefault()
    form = $('#contributor-form', @el)
    userId = $('.id', form).val()
    user = new UserModel(id: userId)
    @election.addContributor(user)
