# ROUTER

class window.AppRouter extends Backbone.Router
  
  routes:
    "candidates": "candidatesList"
    "themes": "themesList"
    "propositions": "propositionsView"
    
  candidatesList: ->
    $('#modal-view').show()
    $('#navigation-view').hide()
    
  themesList: ->
    $('#modal-view').hide()
    $('#navigation-view').show()
    
    $('.page-view').hide()
    $('#themes').show()
    
    unless @themesTableView
      $('#themes').show()
      @themesTableView = new iScroll $('#themes .table-view-container').get(0)
    
  propositionsView: ->
    $('#modal-view').hide()
    $('#navigation-view').show()
    
    $('.page-view').hide()
    $('#propositions').show()

    unless @propositionsTableView
      @propositionsTableView = new iScroll $('#propositions .table-view-container').get(0)
    