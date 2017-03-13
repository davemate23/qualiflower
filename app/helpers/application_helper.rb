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
end
