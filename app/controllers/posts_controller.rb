class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    if user_signed_in?
      @post = Post.new
    else
      redirect_to login_path, info: 'ログインして下さい'
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end



  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :description).merge(user_id: current_user.id)
    end
end
