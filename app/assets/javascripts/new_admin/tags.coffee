$ ->
  $("#form-tag-search").on "submit", (e) ->
    e.preventDefault()

  $("#tag-search").on "keyup", (e) ->
    input = $(this).val().toLowerCase()
    if (event.keyCode > 32 && event.keyCode < 128) || event.keyCode == 8
      $(".tag").each (index, tag) ->
        $tag = $(tag)
        if $tag.text().toLowerCase().search(input) == -1
          $tag.css("display", "none")
        else
          $tag.css("display", "block")
    

