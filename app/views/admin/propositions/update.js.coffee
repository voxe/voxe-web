$("#proposition-fields-<%= @proposition.id %>").replaceWith('<%= escape_javascript(render("proposition_fields", proposition: @proposition))%>')
