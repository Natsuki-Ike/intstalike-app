class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :except=>[:home, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    #@search = Article.search(params[:q])
    # @search = Article.ransack(params[:q]) #ransackメソッド推奨
    # @search_articles = @search.result.page(params[:page])
    @search = Post.ransack(params[:q])
    @posts = @search.result
  end

  def after_sign_in_path_for(user)
    "/users/#{current_user.id}"
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
