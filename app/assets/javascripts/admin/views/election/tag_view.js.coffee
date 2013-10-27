class Admin.Views.Election.TagView extends Backbone.View
  template: JST['admin/templates/election/tag']
  tagName: 'tr'

  events: ->
    'click .remove': 'remove'
    'click .change-name': 'changeName'

  initialize: ->
    $(@el).attr "data-tag-id", @model.id
    @tag = @model
    @election = @options.election
    @candidacy = @options.candidacy
    @tag.bind 'change', @render, @

  remove: (event) =>
    if confirm('Are you sure ?')
      @election.removeTag @tag
      $(@el).hide()

  changeName: (event) =>
    name = prompt "Name :", @tag.get('name')
    @tag.save({name: name})
      success: (model, response) =>
        @render()
      error: (model, response) =>
        console.log "error"

  render: ->
    $(@el).html @template @

    @
