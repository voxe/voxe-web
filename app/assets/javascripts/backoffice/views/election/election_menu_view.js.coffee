class Backoffice.Views.Election.ElectionMenuView extends Backbone.View
  el: '.menu'
  template: JST['backoffice/templates/election/election_menu']

  initialize: () ->
    @election = @model # readability++
    @render()

  render: ->
    $(@el).html @template @
    $(".#{@options.menu_entry}").addClass 'current'

