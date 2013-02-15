class window.EditUserProfileView extends Backbone.View

  className: "edit-profile"

  events:
    "click .save": "save"

  render: ->
    @theater = new TheaterView()
    $(@el).html Mustache.to_html($('#user-edit-profile-template').html(), user: @model.toJSON())
    @theater.play @el
    @

  save: (e) ->
    e.preventDefault()
    theater = @theater
    @model.save {
      name: @.$('input[name=name]').val()
      email: @.$('input[name=email]').val()
      is_anonymous: @.$('input[name=is_anonymous]').is(":checked")
    }, success: -> theater.close()
