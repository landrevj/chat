class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_time_zone, if: :current_user

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  
  protected

  def set_time_zone(&block)
    Time.use_zone(current_user.timezone, &block)
  end

  def configure_permitted_parameters
    added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me, :timezone, :thread_theme, :anonymous]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
