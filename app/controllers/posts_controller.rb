class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.author = @user

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def like
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @like = Like.new(user: @user, post: @post)

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Error liking the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
