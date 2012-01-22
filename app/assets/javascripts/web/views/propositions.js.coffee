class window.PropositionsView extends Backbone.View
  
  tag: ->
    @model.tags.selected()
  
  candidacies: ->
    @model.candidacies.selected().toJSON()
    
  loading: ->
    return true if @collection.length == 0
    false
      
  categories: ->
    return [] if !@tag() || @collection.length == 0
    
    categories = []
    candidacies = @candidacies()
    tags_propositions = @tags_propositions() 
    _.each @tag().tags.toJSON(), (c) ->      
      category = {}
      category.id = c.id
      category.name = c.name
      sections = []
      _.each c.tags, (s) ->
        section = {}
        section.id = s.id
        section.name = s.name
        section.candidacies = _.map candidacies, (c)->
          candidacy = {}
          candidacy.id = c.id
          candidacy.candidates = c.candidates
          if tags_propositions[section.id] && tags_propositions[section.id][candidacy.id]
            candidacy.propositions = tags_propositions[section.id][candidacy.id]
          else
            candidacy.propositions = []
          candidacy
        sections.push section
      category.sections = sections
      categories.push category
    categories
  
  tags_propositions: ->
    hash = {}
    _.each @collection.models, (proposition) ->
      candidacy = proposition.candidacy()
      _.each proposition.tags(), (tag) ->
        hash[tag.id] = {} unless hash[tag.id]
        hash[tag.id][candidacy.id] = [] unless hash[tag.id][candidacy.id]
        hash[tag.id][candidacy.id].push proposition.toJSON()
    hash
  
  initialize: ->
    @collection.bind "reset", @render, @
    # @model.candidacies.bind "change:selected", @loadPropositions, @
    # @model.tags.bind "change:selected", @loadPropositions, @
        
  loadPropositions: ->
    if @candidacies().length != 0 && @tag()?
      @collection.reset ''
      candidacyIds = _.map @model.candidacies.selected().models, (candidate) ->
           candidate.id
      candidacyIds = candidacyIds.join ','
      @collection.fetch data: {electionIds: @model.id, tagIds: @tag().id, candidacyIds: candidacyIds}
    
  render: ->
    $(@el).html Mustache.to_html($('#propositions-template').html(), tag: @tag(), categories: @categories(), loading: @loading())
    @