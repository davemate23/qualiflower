module ApplicationHelper

	def flash_class(level)
		case level
			when :notice then "alert alert-info"
			when :success then "alert alert-success"
			when :error then "alert alert-warning"
			when :alert then "alert alert-danger"
		end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def is_admin?
    current_user && current_user.admin?
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  # def nested_messages(messages)
  #   messages.map do |message, sub_messages|
  #     render(message) + content_tag(:div, nested_messages(sub_messages), :class => "nested_messages")
  #   end.join.html_safe
  # end
  def nested_attributes(attributes)
    content_tag :ul do
      attributes.each do |attribute|
        concat(content_tag(:li, attribute.name))
        if attribute.has_children?
          concat(nested_attributes(attribute.children))
        end
      end
    end
  end

  def nested_groups(groups)
    content_tag(:ul) do
      groups.map do |group, sub_groups|
        content_tag(:li, group.name +  nested_groups(sub_groups))
      end.join.html_safe
    end
  end


end
