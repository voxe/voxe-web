# http://cubiq.org/iscroll-4
document.addEventListener(
  'touchmove', (e) ->
    e.preventDefault()
  ,false
)

document.addEventListener(
  'touchstart', (e) ->
    window.scrollTo 0,0.9
  ,false
)
  
window.addEventListener "load", ->
  # setTimeout hideAddressBar, 0
  window.scrollTo(0,0.9)
  
  page1 = new iScroll $('#modal-view .table-view-container').get(0)
  
  window.app = {models: {}, collections: {}, views:{}}
  app.views.application = new ApplicationView(el: "#application-view")
  app.views.candidatesList = new CandidatesListView(el: "#modal-view")
  app.views.themesList = new ThemesListView(el: "#themes")
  app.views.propositions = new PropositionsView(el: "#propositions")
  
  app.router = new AppRouter()
  Backbone.history.start()
  app.router.navigate "candidates", true
    
  # $('a.compare').click ->
  #   $('#modal-view').hide()
  #   $('#navigation-view').show()
  #       
  #   unless themesTableView
  #     $('#themes').show()
  #     window.themesTableView = new iScroll $('#themes .table-view-container').get(0)