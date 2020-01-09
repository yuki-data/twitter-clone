module ApplicationHelper
  def active_tab?(controller_name)
    return "--highlight" if controller_name == params[:controller]
  end
end
