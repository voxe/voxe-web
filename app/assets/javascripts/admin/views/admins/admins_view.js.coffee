class Backoffice.Views.Admins.AdminsView extends Backbone.View
  el: '.content'
  template: JST['backoffice/templates/admins/admins']

  events:
    'submit #add-admin': 'addAdmin'

  initialize: ->
    @collection.bind 'reset', @render, @
    @collection.bind 'change', ->
      @fetchAdmins()

  render: ->
    $(@el).html(@template())

    @collection.each @renderAdmin

    #autocomplete
    form = $('#add-admin', @el)
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


    @

  renderAdmin: (admin) ->
    $('.admins', @el).append((new Backoffice.Views.Admins.AdminView(model: admin)).render().el)

  addAdmin: (event) ->
    event.preventDefault()
    form = $('#add-admin', @el)
    userId = $('.id', form).val()
    user = new UserModel(id: userId)
    user.bind 'change', =>
      @collection.fetchAdmins()
    user.addAdmin()
