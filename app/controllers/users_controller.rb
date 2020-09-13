class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy,
                                            :following, :followers]
  before_action :set_user, only: [:show]

  def mypage
    redirect_to user_path(current_user)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  # def show
  #  @user = User.find(current_user.id)
  # end

  def new
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザーを更新した"
    else
      render :edit
    end
  end

  def edit
   @user = current_user
 end

 def update_password
   @user = current_user
   if @user.update(user_params)
     # Sign in the user by passing validation in case their password changed
     bypass_sign_in(@user)
     redirect_to root_path
   else
     render "edit"
   end
 end

 def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image,
                                   :fullname, :self_introduction, :website)
    end

end
