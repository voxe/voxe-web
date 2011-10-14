class window.ElectionModel extends Backbone.Model
  
  urlRoot: '/api/v1/elections'
  
  addThemeId: (themeId)->
    
  
  addCandidateId: (candidateId)->
    
  
  toJSON: ->
    object = _.clone(@attributes)
    for key,value of object      
      if value instanceof Backbone.Model
        object[key] = value.toJSON()
    object
    
  parse: (response)->
    response.election
    
  set: (attributes = {}) ->
    # candidates
    if attributes.candidates && attributes.candidates.length != 0
      attributes.candidates = new CandidatesCollection(attributes.candidates)
      
    # themes
    if attributes.themes && attributes.themes.length != 0
      attributes.themes = new ThemesCollection(attributes.themes)

    super attributes