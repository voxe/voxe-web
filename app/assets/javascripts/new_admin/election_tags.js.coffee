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
        $tag.show()
        acc || true
      else
        $tag.hide()
        acc || false
    , false)

  getTag = (id, cb) ->
    $.ajax
      url: '/api/v1/tags/' + id
      method: 'GET'
      success: (response, status, xhr) ->
        cb(response.response.tag)
      error: (xhr, status, body) ->
        cb({})

  buildTagsSelect = (select, filterIds) ->
    filterIds = []
    $(".tag").each ->
      filterIds.push this.id
    select.select2
      ajax:
        url: '/api/v1/tags/search'
        dataType: 'json'
        placeholder: "Search for a tag"
        minimumInputLength: 1
        data: (term, page) ->
          name: term
        results: (data, page) ->
          results: _.filter data.response, (tag) ->
            filterIds.indexOf(tag.id) == -1
      formatResult: (tag) ->
        tag.name
      formatSelection: (tag) ->
        tag.name

  buildNewTag = (elem) ->
    # Build our tag and add it to the page
    # We first check who's the parent node to manage the class
    buttons = $("<button></button>").text("-").addClass("btn").addClass("rm-tag").on("click", removeTag)
    addButton = $("<button></button>").text("+").addClass("btn").addClass("add-tag").on("click", addTag)
    classes = $(elem).parent().parent().attr "class"
    if classes.indexOf("container-fluid") != -1
      tag_class = "root-tag"
      buttons = buttons.before addButton
    else if classes.indexOf("root-tag") != -1
      tag_class = "sub-tag"
      buttons = buttons.before addButton
    else if classes.indexOf("sub-tag") != -1
      tag_class = "sub-sub-tag"

    # We create the HTML tag directly
    $("<li></li>").
      addClass(tag_class).
      addClass("tag").
      addClass("span2").
      attr("id", elem.tag.id).
      append(
        $("<div></div>").
        addClass("tag-name").
        text(elem.tag.name).
        append(buttons)
      ).
      append($("<ul></ul>"))

  addRootTag = (e) ->
    select = $("<div></div>")
    $(this).parent().append(select)
    buildTagsSelect(select)
    select.on "change", (e) =>
      getTag e.val, (tag) =>
        @tag = tag
        $.ajax
          url: '/api/v1/elections/'+ $(".election-tags").attr("id") + '/addtag'
          type: 'POST'
          data:
            tagId: tag.id
          success: (response, status, xhr) =>
            select.select2("destroy")
            $(".election-tags").prepend buildNewTag(@)

  addTag = (e) ->
    select = $("<div></div>")
    $(this).parent().append(select)
    buildTagsSelect(select)

    select.on "change", (e) =>
      getTag e.val, (tag) =>
        if tag == {}
          false
        else
          @tag = tag
          $.ajax
            url: '/api/v1/elections/'+ $(".election-tags").attr("id") + '/addtag'
            type: 'POST'
            data:
              tagId: tag.id
              parentTagId: $(this).parent().parent().attr("id")
            success: (response, status, xhr) =>
              # Remove select2, we don't need it anymore
              select.select2("destroy")
              $(this).parent().next().prepend buildNewTag(@)
            error: (response, status, body) ->
              if $(".alert").size() == 0
                $("body .container-fluid").prepend $('<div class="alert alert-error"></div>')
              $(".alert").text(response.responseText)
              $(".alert").show()

  removeTag = (e) ->
    $.ajax
      url: '/api/v1/elections/' + $(".election-tags").attr("id") + '/removetag'
      type: 'DELETE'
      data:
        tagId: $(this).parent().parent().attr('id')
      success: (response, status, body) =>
        $(this).parent().parent().remove()
      error: (response, status, body) =>
        if response.status == 200
          $(this).parent().parent().remove()


  $(".add-root-tag").on "click", addRootTag
  $(".add-tag").on "click", addTag
  $(".rm-tag").on "click", removeTag
  
