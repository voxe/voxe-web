class window.PropositionsView extends Backbone.View
  
  theme: ->
    app.models.theme
  
  candidates: ->
    app.collections.selectedCandidates.toJSON()
  
  categories: ->
    categories = []
    candidates = @candidates()
    propositions = @propositions()
    _.each @theme().themes(), (c) ->
      category = {}
      category.id = c.id
      category.name = c.name
      sections = []
      _.each c.themes, (s) ->
        section = {}
        section.id = s.id
        section.name = s.name
        section.candidates = _.map candidates, (c)->
          candidate = {}
          candidate.id = c.id
          candidate.firstName = c.firstName
          candidate.photo = c.photo
          if propositions[section.id] && propositions[section.id][candidate.id]
            candidate.propositions = propositions[section.id][candidate.id]
          else
            candidate.propositions = []
          candidate
        sections.push section
      category.sections = sections
      categories.push category
    categories
  
  propositions: ->
    hash = {}
    _.each app.collections.propositions.models, (proposition) ->
      theme = proposition.theme()
      candidate = proposition.candidate()
      hash[theme.id] = {} unless hash[theme.id]
      hash[theme.id][candidate.id] = [] unless hash[theme.id][candidate.id]
      hash[theme.id][candidate.id].push proposition.toJSON()
    hash
  
  initialize: ->
    app.collections.propositions.bind "reset", @render, @
    app.collections.selectedCandidates.bind "change", @loadPropositions, @
    app.models.theme.bind "change", @loadPropositions, @
        
  loadPropositions: ->
    app.collections.propositions.fetch()
    
  render: ->
    $(@el).html Mustache.to_html($('#propositions-template').html(), theme: @theme(), categories: @categories())
    unless @scrollView
      @scrollView = new iScroll $('#compare .table-view-container').get(0)
    setTimeout @refreshScroll, 0
    
  refreshScroll: =>
    @scrollView.refresh()
    @scrollView.scrollTo 0, 0, 0