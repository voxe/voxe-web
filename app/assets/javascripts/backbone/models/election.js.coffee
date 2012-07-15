class window.ElectionModel extends Backbone.Model
  
  # http://voxe.org/platform/models/election
  
  urlRoot: "/api/v1/elections"

  url: ->
    if @id
      "#{@urlRoot}/#{@id}"
    else
      @urlRoot

  initialize: ->
    @.bind 'error', @processErrors
    @candidacies = new CandidaciesCollection(@get 'candidacies')
    @tags = new TagsCollection(@get 'tags')
    @tags.election = @
    
    @bind "change:candidacies", (election) =>
      @candidacies.reset election.get "candidacies"
      
    @bind "change:tags", (election) =>
      @tags.reset election.get "tags"

  name: ->
    @get "name"
    
  namespace: ->
    @get "namespace"
  
  toJSON: ->
    hsh = super
    hsh.candidacies = @candidacies.toJSON()
    hsh.tags = @tags.toJSON()
    hsh

  parse: (response)->
    # deleted because the bind "change:candidacies" should take care of this
    # @candidacies.reset response.response.election.candidacies
    # @tags.reset response.response.election.tags
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

  addCandidate: (candidate) ->
    election = @
    data = {candidateIds: candidate.id}
    unless candidate.id
      return 0
    $.ajax
      type: 'POST'
      url: "#{@url()}/addcandidacy"
      data: $.param(data)
      success: (response) ->
        election.fetch(data: {tags: 'all', published: 'all'})
      error: (response) ->
        election.trigger 'error', election, response

  removeTag: (tag) ->
    election = @
    $.ajax
      type: 'DELETE'
      url: "#{@url()}/removetag"
      data: {tagId: tag.id}
      complete: (response) ->
        if response.status == 200
          election.fetch(data: {tags: 'all', published: 'all'})

  togglePublish: ->
    if @get 'published'
      @save {published: false}
    else
      @save {published: true}

  moveTags: (tagIds) ->
    election = @
    $.ajax
      type: 'POST'
      url: "#{@url()}/movetags"
      data: tagIds: tagIds
      # TODO add callback

  sync: (method, model, options) ->
    options ||= {}
    if method is 'update'
      modelData = ['published', 'date']
      params =
        type: 'PUT'
        dataType: 'json'
        contentType: 'application/json'
        data: JSON.stringify(_.reduce(
          model.attributes
          (memo, val, key) ->
            memo[key] = val if _.include(modelData, key)
            memo
          {}
        ))
        url: @url()
      $.ajax(_.extend(params, options))
    else
      Backbone.sync(method, model, options)

