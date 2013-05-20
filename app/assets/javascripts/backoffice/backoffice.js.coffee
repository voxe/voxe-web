//= require jquery
//= require select2
//= require_self

$(document).ready ->
  try
    $("#proposition_tag_ids").val(gon.proposition_tags).select2()
  catch error
    $("#proposition_tag_ids").select2()
