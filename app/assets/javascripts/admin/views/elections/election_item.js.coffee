class Admin.Views.Elections.ElectionItemView extends Backbone.View
  tagName: 'tr'

  template: JST['admin/templates/elections/election_item']

  events:
    'click .toggle-publish': 'togglePublish'
    'click .display-rename-form': 'displayRenameForm'
    'submit form.rename-election-form': 'submitRenameForm'
    'click .cancel-rename-form': 'cancelRenameForm'

  initialize: ->
    @election = @model
    @election.bind 'change', @render, @

  render: ->
    $(@el).html @template @

    $('input[type=text]', @el).hide()
    $('.submit-rename-form', @el).hide()
    $('.cancel-rename-form', @el).hide()

    @

  togglePublish: ->
    @election.togglePublish()

  displayRenameForm: ->
    $('input[type=text]', @el).val(@election.get 'name')


    $('input[type=text]', @el).show()
    $('.display-rename-form', @el).hide()
    $('a', @el).hide()
    $('.submit-rename-form', @el).show()
    $('.cancel-rename-form', @el).show()

  submitRenameForm: (event) ->
    event.preventDefault()
    electionName = $('input[name=electionName]', @el).val()
    @election.save {}, data: $.param
      election:
        name: electionName
        #namespace: electionName.replace /\s+/g, '-' # TODO: should be compute by API

  cancelRenameForm: ->
    @render()
