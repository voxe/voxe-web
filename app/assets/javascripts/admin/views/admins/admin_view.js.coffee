class Backoffice.Views.Admins.AdminView extends Backbone.View
  tagName: 'tr'
  template: JST['backoffice/templates/admins/admin']

  events:
    'click .remove': 'removeAdmin'

  initialize: ->
    @model.bind 'change', => @trigger 'adminChanged'

  render: ->
    $(@el).html @template(@model.toJSON())

    $('.remove', @el).hide() if @model.get('email') is 'admin@voxe.org'

    @

  removeAdmin: ->
    @model.removeAdmin()
