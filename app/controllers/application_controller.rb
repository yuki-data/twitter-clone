class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def production?
    if Rails.env.production?
      true unless ENV["BASIC_AUTH"] && (ENV["BASIC_AUTH"] == "false")
    end
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      valid_user = username == "admin"
      valid_password = password == Rails.application.credentials.basic_auth[:password]
      valid_user && valid_password
    end
  end
end
