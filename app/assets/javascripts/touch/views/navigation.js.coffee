class window.NavigationView extends Backbone.View

  push: (id) ->
    $('.page-view', @el).hide()
    $("##{id}", @el).show()