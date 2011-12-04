module BackofficeHelper
  def active_menu menu
    'active' if menu == controller_name
  end

  def link_to_remove_fields(name, f, options = {})
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", options)
  end

  def link_to_add_fields(name, f, association, view = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render((view || association).to_s.singularize + "_fields", :f => builder)
    end.html_safe
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end
end
