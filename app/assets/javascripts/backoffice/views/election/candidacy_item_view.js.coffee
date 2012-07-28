class Backoffice.Views.Election.CandidacyItemView extends Backbone.View
  tagName: 'tr'
  template: JST['backoffice/templates/election/candidacy_item']

  events: ->
    'click .toggle-publish': 'togglePublish'
    'click .change-picture-button': 'changePictureButton'
    'change .change-picture': 'changePicture'
    'click .change-first-name': 'changeFirstName'
    'click .change-last-name': 'changeLastName'
    'click .change-namespace': 'changeNamespace'
    'click .delete': 'delete'

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

  changeFirstName: (event) ->
    firstName = prompt "First name :", @candidate.get('firstName')
    @candidate.save {firstName: firstName}
      success: (model, response) ->
        console.log "success"
      error: (model, response) ->
        console.log "error"

  changeLastName: (event) ->
    lastname = prompt "Last name :", @candidate.get('lastName')
  
  changeNamespace: (event) ->
    namespace = prompt "Namespace :", @candidate.get('namespace')
  
  togglePublish: (event) ->
    @candidacy.save {}, data: $.param(candidacy: {published: (not @candidacy.get 'published')})

  changePictureButton: (event) ->
    $(@el).find('input[type=file]').trigger('click')

  changePicture: (event) ->
    image =  $('input[type=file]', @el)[0].files[0]
    @candidate.addPhoto image

  delete: (event) ->
    @candidacy.destroy({
      success: (model, response) ->
        $(@el).hide()
      error: (model, response) ->
        console.log response
    })
