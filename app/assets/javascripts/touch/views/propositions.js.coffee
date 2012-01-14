class window.PropositionsView extends Backbone.View
  
  tag: ->
    if app.models.election.tags.selected()
      tag = app.models.election.tags.selected()
    else
      tag = null
  
  candidacies: ->
    app.models.election.candidacies.selected().toJSON()
  
  categories: ->
    return [] unless @tag()
    
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
    _.each app.collections.propositions.models, (proposition) ->
      candidacy = proposition.candidacy()
      _.each proposition.tags(), (tag) ->
        hash[tag.id] = {} unless hash[tag.id]
        hash[tag.id][candidacy.id] = [] unless hash[tag.id][candidacy.id]
        hash[tag.id][candidacy.id].push proposition.toJSON()
    hash
  
  initialize: ->
    app.collections.propositions.bind "reset", @render, @
    app.models.election.candidacies.bind "change:selected", @loadPropositions, @
    app.models.election.tags.bind "change:selected", @loadPropositions, @
        
  loadPropositions: ->
    if @candidacies().length != 0 && @tag()?
      candidacyIds = _.map app.models.election.candidacies.selected().models, (candidate) ->
           candidate.id
      candidacyIds = candidacyIds.join ','
      app.collections.propositions.fetch data: {electionIds: app.models.election.id, tagIds: @tag().id, candidacyIds: candidacyIds}
    
  render: ->
    $(@el).html Mustache.to_html($('#propositions-template').html(), tag: @tag(), categories: @categories())
    unless @scrollView
      @scrollView = new iScroll $('#compare .table-view-container').get(0)
    setTimeout hideURLbar, 0
    setTimeout @refreshScroll, 0
    
  refreshScroll: =>
    @scrollView.refresh()
    @scrollView.scrollTo 0, 0, 0