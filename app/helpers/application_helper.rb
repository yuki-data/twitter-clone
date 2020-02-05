module ApplicationHelper
  def active_tab?(controller_name, action_name=nil)
    return unless controller_name == params[:controller]
    return if action_name && action_name != params[:action]
    "--highlight"
  end

  def show_profile?
    params[:controller] == "users" && params[:action] == "show"
  end
end
