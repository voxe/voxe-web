class window.CandidateModel extends Backbone.Model
  
  # http://voxe.org/platform/models/candidate
  
  firstName: ->
    @get "firstName"
    
  lastName: ->
    @get "lastName"

  toString: ->
    "#{@get 'firstName'} #{@get 'lastName'}"

  urlRoot:
    "/api/v1/candidates/"

  parse: (response) ->
    response.response.candidate

  addPhoto: (image) ->
    data = new FormData()
    data.append 'image', image
    $.ajax
      type: 'POST'
      data: data
      cache: false
      contentType: false
      processData: false
      url: "/api/v1/candidates/#{@id}/addphoto"
      complete: (response) ->
