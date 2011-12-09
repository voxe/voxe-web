class window.PropositionsView extends Backbone.View
  
  events:
    "click a.button": "themesClick"
    
  themesClick: ->      
    app.router.navigate "themes", true
    
  initialize: ->
    # themeId = app.models.themeSelected.id
    # candidatesIds = []
    # app.collections.candidates.each (candidate) ->
    #   candidatesIds.push candidate.id if candidate.get('selected')
    # 
    # $.get "/plugins/compare/propositions",
    #       {electionId: app.models.election.id, themeId: themeId, candidateIds: candidatesIds.join(',')},
    #       (data) =>
    #         $(@el).html data