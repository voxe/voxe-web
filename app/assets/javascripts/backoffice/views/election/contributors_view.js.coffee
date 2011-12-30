class Backoffice.Views.ContributorsView extends Backbone.View
  el: '.content'

  initialize: ->
    @render()

  render: ->
    $().html @templates.main @
