class window.ElectionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/election
  
  urlRoot: "/api/v1/elections"

  initialize: ->
    @.bind 'error', @processErrors

  name: ->
    @get "name"
  
  candidacies: ->
    @get "candidacies"
    
  tags: ->
    @get "tags"
  
  toJSON: ->
    object = _.clone(@attributes)
    for key,value of object      
      if value instanceof Backbone.Model
        object[key] = value.toJSON()
    object
  
  parse: (response)->
    @candidacies = new CandidaciesCollection(response.response.election.candidacies)
    @tags = new TagsCollection(response.response.election.tags)
    @tags.election = @
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

  addTag: (options) ->
    tag_id = options.tag_id
    parent_tag_id = options.parent_tag_id
    url = "http://voxe-web.dev#{@url()}/addtag"
    if parent_tag_id
      data = "tagId=#{tag_id}&parentTagId=#{parent_tag_id}"
    else
      data = "tagId=#{tag_id}"
    $.ajax
      type: 'POST'
      url: url
      data: data
      success: (response) ->
        options.success(response) if options.success
      error: (response, error) ->
        options.error($.parseJSON(response.responseText).response.errors) if options.error
