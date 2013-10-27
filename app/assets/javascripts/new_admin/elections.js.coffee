$ ->
  $("#election_name").on "keyup", (e) ->
    $("#election_namespace").val(
      $(this).val().toLowerCase().replace /\s+/g, '-'
    )
  
  $("#election_namespace").on "keypress", (e) ->
    $("#election_name").off "keyup"
