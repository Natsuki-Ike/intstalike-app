class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :except=>[:home, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    "/user/#{current_user.id}"
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:image])
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
  end
end
