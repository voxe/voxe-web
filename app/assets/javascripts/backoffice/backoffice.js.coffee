@remove_fields = (link) ->
  $(link).prev().val "true"
  $(link).parent().hide()

@add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp "new_" + association, "g"
  if $(link).parent().find("div.embed").length < 1
    $(link).parent().find("h5").after content.replace(regexp, new_id)
  else
    $(link).parent().find("div.embed").last().after content.replace(regexp, new_id)

@test_link = (link, website = null) ->
  value = $(link).prev().val()
  if(website)
    final_link = "http://www." + website + ".com/" + value
  else if (value.search("http://") is -1)
    final_link = "http://" + value
  else
    final_link = value

  window.open(final_link)

$ ->
  if gon?
    if gon.page is "new"
      $("#proposition_tag_ids").select2()
    else if gon.page is "edit"
      $("#proposition_tag_ids").val(gon.proposition_tags).select2()

