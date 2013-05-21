#= require jquery
#= require select2
#= require_self

@remove_fields = (link) ->
  $(link).prev().find('div').find('input').val("true")
  $(link).parent().hide()

@add_fields = (link, association, content) ->
  new_id = new Date().getTime();
  regexp = new RegExp("new_" + association, "g");
  $(link).prepend(content.replace(regexp, new_id))

$ ->
  try
    $("#proposition_tag_ids").val(gon.proposition_tags).select2()
  catch error
    $("#proposition_tag_ids").select2()
