class Admin.Views.Election.CandidacyView extends Backbone.View
  tagName: 'tr'
  template: JST['admin/templates/election/candidacy']

  events: ->
    'click .toggle-publish': 'togglePublish'
    'click .change-picture-button': 'changePictureButton'
    'change .change-picture': 'changePicture'
    'click .change-first-name': 'changeFirstName'
    'click .change-last-name': 'changeLastName'
    'click .change-namespace': 'changeNamespace'
    'click .delete-candidate': 'deleteCandidate'
    'click .delete-candidacy': 'deleteCandidacy'

  initialize: ->
    @candidacy = @model
    @candidate = @candidacy.candidates.first()
    @election = @options.election
    @candidacy.bind 'change', @render, @
    $(@el).attr "data-candidacy-id", @model.id

  render: ->
    $(@el).html @template @
    $(@el).find('.change-picture').hide()

    @

  togglePublish: (event) ->
    @candidacy.save {}, data: $.param(candidacy: {published: (not @candidacy.get 'published')})

  changePictureButton: (event) ->
    $(@el).find('input[type=file]').trigger('click')

  changePicture: (event) ->
    image =  $('input[type=file]', @el)[0].files[0]
    @candidate.addPhoto image

  deleteCandidate: (event) =>
    if confirm('Are you sure ? It will also delete the candidacy')
      @candidate.destroy
        success: (model, response) =>
          $(@el).hide()
        error: (model, response) =>
          console.log "error"
          $(@el).hide()

  deleteCandidacy: (event) =>
    if confirm('Are you sure ?')
      @candidacy.destroy
        success: (model, response) =>
          $(@el).hide()
        error: (model, response) =>
          console.log "error"
          $(@el).hide()

  changeFirstName: (event) =>
    firstName = prompt "First name :", @candidate.get('firstName')
    @candidate.save
      candidate:
        first_name: firstName
      success: (model, response) =>
        @render()
      error: (model, response) =>
        console.log "error"

  changeLastName: (event) =>
    lastName = prompt "Last name :", @candidate.get('lastName')
    @candidate.save
      candidate:
        last_name: lastName
      success: (model, response) =>
        @render()
      error: (model, response) =>
        console.log "error"
  
  changeNamespace: (event) =>
    namespace = prompt "Namespace :", @candidate.get('namespace')
    @candidate.save
      candidate:
        namespace: namespace
      success: (model, response) =>
        @render()
      error: (model, response) =>
        console.log "error"
