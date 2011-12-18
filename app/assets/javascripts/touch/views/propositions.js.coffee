class window.PropositionsView extends Backbone.View
  
  tag: ->
    app.models.tag
  
  candidates: ->
    app.collections.selectedCandidates.toJSON()
  
  categories: ->
    categories = []
    candidates = @candidates()
    tags_propositions = @tags_propositions()
    _.each @tag().tags(), (c) ->
      category = {}
      category.id = c.id
      category.name = c.name
      sections = []
      _.each c.tags, (s) ->
        section = {}
        section.id = s.id
        section.name = s.name
        section.candidates = _.map candidates, (c)->
          candidate = {}
          candidate.id = c.id
          candidate.firstName = c.firstName
          candidate.photo = c.photo
          if tags_propositions[section.id] && tags_propositions[section.id][candidate.id]
            candidate.propositions = tags_propositions[section.id][candidate.id]
          else
            candidate.propositions = []
          candidate
        sections.push section
      category.sections = sections
      categories.push category
    categories
  
  tags_propositions: ->
    hash = {}
    _.each app.collections.propositions.models, (proposition) ->
      candidate = proposition.candidate()
      _.each proposition.tags(), (tag) ->
        hash[tag.id] = {} unless hash[tag.id]
        hash[tag.id][candidate.id] = [] unless hash[tag.id][candidate.id]
        hash[tag.id][candidate.id].push proposition.toJSON()
    hash
  
  initialize: ->
    app.collections.propositions.bind "reset", @render, @
    app.collections.selectedCandidates.bind "reset", @loadPropositions, @
    app.models.tag.bind "change", @loadPropositions, @
        
  loadPropositions: ->
    if @candidates().length != 0 && @tag().id
      app.collections.propositions.fetch()
    
  render: ->
    $(@el).html Mustache.to_html($('#propositions-template').html(), tag: @tag(), categories: @categories())
    unless @scrollView
      @scrollView = new iScroll $('#compare .table-view-container').get(0)
    setTimeout @refreshScroll, 0
    
  refreshScroll: =>
    @scrollView.refresh()
    @scrollView.scrollTo 0, 0, 0