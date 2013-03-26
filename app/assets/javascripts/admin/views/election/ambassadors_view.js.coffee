class Admin.Views.Election.AmbassadorsView extends Backbone.View
  el: '#modal-ambassadors .modal-body'
  template: JST['admin/templates/election/ambassadors']

  events:
    'submit #ambassador-form': 'addAmbassador'

  initialize: ->
    @election = @model
    @collection = @election.ambassadors()
    @collection.bind 'reset', @render, @
    @render()

  render: ->
    $(@el).html @template @

    #autocomplete
    form = $('#ambassador-form', @el)
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

  fetch_amabassadors: ->
    @collection.fetch()

  addAmbassador: ->
    event.preventDefault()
    form = $('#ambassador-form', @el)
    userId = $('.id', form).val()
    user = new UserModel(id: userId)
    @election.addAmbassador(user)
