class window.ElectionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/election
  
  urlRoot: "/api/v1/elections"

  initialize: ->
    @.bind 'error', @processErrors
    @candidacies = new CandidaciesCollection(@get 'candidacies')
    @tags = new TagsCollection(@get 'tags')
    @tags.election = @

  name: ->
    @get "name"
    
  namespace: ->
    @get "namespace"
  
  toJSON: ->
    object = _.clone(@attributes)
    for key,value of object      
      if value instanceof Backbone.Model
        object[key] = value.toJSON()
    object
  
  parse: (response)->
    @candidacies.reset response.response.election.candidacies
    @tags.reset response.response.election.tags
    response.response.election

  # {namespace: ["is already taken"]}
  processErrors: (election, response) ->
    errors = ($.parseJSON response.responseText).response.errors
    @.error_messages = _.reduce errors,
      (memo, messages, attribute) ->
        _.each messages,
          (message) -> memo.push("#{attribute} #{message}")
        memo
      []

  addTag: (tag, parent_tag) ->
    election = @
    data = {tagId: tag.id}
    data['parentTagId'] = parent_tag.id if parent_tag
    $.ajax
      type: 'POST'
      url: "#{@url()}/addtag"
      data: $.param(data)
      success: (response) ->
        if parent_tag
          parent_tag.tags.add tag
        else
          election.tags.add tag
      error: (response) ->
        election.trigger 'error', election, response