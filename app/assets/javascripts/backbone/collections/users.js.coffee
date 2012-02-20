class window.UsersCollection extends Backbone.Collection
  model: UserModel

  url: ->
    '/api/v1/users/search'

  parse: (response) ->
    response.response

  fetchAdmins: ->
    @fetch(url: '/api/v1/users/admins')
