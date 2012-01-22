class window.ApplicationView extends Backbone.View
  
  scrollTo: (position)->
    $('html,body').animate scrollTop: (position - 80), 1000