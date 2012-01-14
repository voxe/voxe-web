class window.TagsCollection extends Backbone.Collection
  
  model: TagModel

  search: (name) ->
    @fetch {url: "/api/v1/tags/search", data: {name: name}}

  depthTagSearch: (tag_id) ->
    res = null
    res ||= @.find (tag) ->
      tag.id == tag_id
    res ||= @.reduce(
      (memo, tag) ->
        memo || tag.tags.depthTagSearch tag_id
      null
    )

  getElection: ->
    @election || (@parent_tag.collection.getElection() if @parent_tag && @parent_tag.collection)

  parse: (response) ->
    response.response

  validateAndAdd: (tag, errors_callback) ->
    if election = @getElection()
      self = @
      election.addTag
        tag_id: tag.id
        parent_tag_id: @parent_tag.id if @parent_tag
        success: (response) ->
          self.add tag
        error: (errors) ->
          error_messages = _.reduce(errors,
            (memo, val, key) ->
              _.each val, ->
                memo.push self.errorMessage(key, val)
              memo
            []
          )
          errors_callback.call(self, error_messages)

  errorMessage: (attribute, message) ->
    "#{attribute} #{message}"
    
  setSelected: (tagId) ->
    _.each @models, (tag) ->
      tag.set selected: (tag.id == tagId)

  selected: ->
    tag = _.find @models, (tag) ->
      tag.isSelected() == true
    if _.isEmpty(tag)
      null
    else
      tag