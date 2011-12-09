$("edit-proposition-<%= @proposition.id %>").html('<%= escape_javascript(render("proposition_fields", proposition: @proposition))%>')
