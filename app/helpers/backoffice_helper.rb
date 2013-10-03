module BackofficeHelper
  def active_menu menu
    'active' if menu == controller_name
  end

  def link_to_remove_fields(name, f, options = {})
    f.hidden_field(:_destroy) + link_to_function(tag(:i, class: 'icon-remove-sign') + ' ' + name, "remove_fields(this)", options)
  end

  def link_to_add_fields(name, f, association, css_class)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render((association).to_s.singularize + "_fields", :f => builder)
    end.html_safe
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')",  :class => css_class)
  end

  def link_to_test_link(name, website, options = {})
    if website.size != 0
      link_to_function(name, "test_link(this, '#{website}')", options)
    else
      link_to_function(name, "test_link(this)", options)
    end
  end
end
