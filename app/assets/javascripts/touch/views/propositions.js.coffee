class window.PropositionsView extends Backbone.View
  
  theme: ->
    app.models.theme
  
  candidates: ->
    app.collections.selectedCandidates.toJSON()
  
  categories: ->
    categories = []
    candidates = @candidates()
    propositions = @propositions()
    _.each @theme().themes(), (category) ->
      sections = []
      _.each category.themes, (section) ->
        section.candidates = _.map candidates, (candidate)->
          candidate.propositions = propositions[section.id][candidate.id]
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
  
  # TODO: change this method name
  show: ->
    app.collections.propositions.fetch()
  
  events:
    "click a.button": "themesClick"
    
  themesClick: ->
    app.router.themesList()
    
  render: ->
    $(@el).html Mustache.to_html($('#propositions-template').html(), theme: @theme(), categories: @categories())
    
    new iScroll $('.table-view-container', @el).get(0)