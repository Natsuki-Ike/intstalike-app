class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]
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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザーを更新した"
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image )
    end
end
