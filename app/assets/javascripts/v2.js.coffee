//= require jquery

$ ->
  $('.election').click ->
    $('#candidacies').fadeIn 1300
    $('body').animate
      scrollTop: ($('#candidacies').offset().top - 120)
    $('.elections').animate
      opacity: 0.6
      
  $('.candidacies .item').click ->
    $('#themes').fadeIn 1300
    $('body').animate
      scrollTop: ($('#themes').offset().top - 120)
      
  $('.themes .theme').click ->
    $('.container').fadeIn 1300
    $('body').animate
      scrollTop: ($('.container').offset().top - 100)