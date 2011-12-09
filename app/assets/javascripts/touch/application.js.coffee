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
  
  window.themesTableView = window.propositionsTableView = null
  
  $('a.compare').click ->
    $('#modal-view').hide()
    $('#navigation-view').show()
        
    unless themesTableView
      $('#themes').show()
      window.themesTableView = new iScroll $('#themes .table-view-container').get(0)
      
  $('span').click (e)->
    $(e.target).append('traveled to the heart of Republican Kansas on Tuesday')
    setTimeout(->
      propositionsTableView.refresh()
    , 0)
    
  $('#toolbar a').click ->
    $('#modal-view').show()
    $('#navigation-view').hide()
  
  $('a.themes').click ->
    $('.page-view').hide()
    $('#themes').show()
 
  $('a.propositions').click ->
    $('.page-view').hide()
    $('#propositions').show()

    unless propositionsTableView
      window.propositionsTableView = new iScroll $('#propositions .table-view-container').get(0) 