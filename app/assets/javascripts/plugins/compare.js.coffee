# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# ROUTER

class window.AppRouter extends Backbone.Router
  
  routes:
    "candidates": "candidatesList"
    "themes": "themesList"
    "propositions": "propositionsView"
    
  candidatesList: ->
    app.views.candidatesList = new CandidatesListView()
    $("#application-view").html app.views.candidatesList.render().el
    
  themesList: ->
    view = new ThemesListView()
    $("#application-view").html view.render().el
    
  propositionsView: ->
    view = new PropositionsView()
    $("#application-view").html view.render().el

# MODELS

class window.ThemeModel extends Backbone.Model

class window.CandidateModel extends Backbone.Model

class window.ElectionModel extends Backbone.Model
  
  toJSON: ->
    object = _.clone(@attributes)
    for key,value of object      
      if value instanceof Backbone.Model
        object[key] = value.toJSON()
    object
  
  parse: (response)->
    response.election
  
  url: ->
    "/api/v1/elections/#{@id}"
    
# COLLECTIONS

class window.CandidatesCollection extends Backbone.Collection
  
  model: CandidateModel
  
# VIEWS
    
class window.PropositionsView extends Backbone.View
  
  id: "propositions-view"
  
  initialize: ->
    themeId = app.models.themeSelected.id
    candidatesIds = []
    app.collections.candidates.each (candidate) ->
      candidatesIds.push candidate.id if candidate.get('selected')
    
    $.get "/plugins/compare/propositions",
          {electionId: app.models.election.id, themeId: themeId, candidateIds: candidatesIds.join(',')},
          (data) =>
            $(@el).html data
    
class window.ThemesListView extends Backbone.View
  
  events:
    "click ul.themes li": "themeClick"
  
  id: "themes-list-view"
  
  themeClick: (e)->
    li = $(e.target).closest('li')
    themeId = li.attr("theme-id")
    theme = _.find app.models.election.get('themes'), (theme) ->
      theme.id == themeId
    app.models.themeSelected = new ThemeModel(theme)
    
    app.router.navigate "propositions", true
  
  initialize: ->
    app.models.election.bind 'change', @render, @
  
  render: ->
    $(@el).html Mustache.to_html($('#themes-list-template').html(), election: app.models.election.toJSON())
    @

class window.CandidatesListView extends Backbone.View
  
  id: "candidates-list-view"
  
  initialize: ->
    app.models.election.bind 'change', @render, @
    app.collections.candidates.bind 'change', @render, @
    app.models.election.fetch()
        
  render: ->
    $(@el).html Mustache.to_html($('#candidates-list-template').html(),
                                 election: app.models.election.toJSON(),
                                 candidates: app.collections.candidates.toJSON())
    @
    
  events:
    "click ul.candidates li": "candidateClick"
    "click a.compare-button": "compareClick"
    
  candidateClick: (e)->
    li = $(e.target).closest('li')
    candidateId = $(li).attr("candidate-id")
    candidate = app.collections.candidates.get candidateId
    if candidate.get 'selected'
      candidate.set {selected: false}
    else
      candidate.set {selected: true}
    
  compareClick: ->      
    app.router.navigate "themes", true
  
class window.Plugin
  
  constructor: (options) ->
    $ ->  
      window.app = {models: {}, collections: {}, views:{}}
      
      app.models.election = new ElectionModel(id: options.electionId)
      app.collections.candidates = new CandidatesCollection()
  
      app.models.election.bind 'change', (election)->
        app.collections.candidates.add election.get('candidates')
  
      app.router = new AppRouter()
      Backbone.history.start()
      app.router.navigate "candidates", true