$ ->
  # Prevent from sending form
  $("#form-tag-search").on "submit", (e) ->
    e.preventDefault()

  # Listen on keyup to trigger tags filtering
  $("#tag-search").on "keyup", (e) ->
    input = $(this).val().toLowerCase()
    if (e.keyCode > 32 && e.keyCode < 128) || e.keyCode == 8
      filterTags(input)

  filterTags = (input) ->
    filterTagsTree($('.root-tag'), input)

  matchTagName = (tag, input) ->
    tag.children().first().text().toLowerCase().search(input) != -1

  filterTagsTree = (tags, input) ->
    _.reduce(tags, (acc, tag) ->
      $tag = $(tag)
      # If the name matches or if a subnode matches
      # the input We keep the parent node
      if filterTagsTree($tag.find("li"), input) || matchTagName($tag, input)
        $tag.css("display", "block")
        acc || true
      else
        $tag.css("display", "none")
        acc || false
    , false)


