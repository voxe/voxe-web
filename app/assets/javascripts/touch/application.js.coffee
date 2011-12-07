# http://cubiq.org/iscroll-4
document.addEventListener(
  'touchmove', (e) ->
    e.preventDefault()
  ,false
)

hideAddressBar= ->
  # http://davidwalsh.name/hide-address-bar
  # bug
  window.scrollTo 0, 1

init= ->
  # http://cubiq.org/iscroll-4
  tableView = new iScroll $('#page1 .table-view-container').get(0)

window.addEventListener "load", ->
  # setTimeout hideAddressBar, 0
  setTimeout init, 200
  
  pageOne = pageTwo = null
  
  $('a.page1').click ->
    $('.page-view').hide()
    $('#page1').show()
    
    unless page1
      page1 = new iScroll $('#page1 .table-view-container').get(0)
  
  $('a.page2').click ->
    $('.page-view').hide()
    $('#page2').show()
    
    unless page2
      page2 = new iScroll $('#page2 .table-view-container').get(0)
 
  $('a.page3').click ->
    $('.page-view').hide()
    $('#page3').show()

    unless page3
      page3 = new iScroll $('#page3 .table-view-container').get(0) 