class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = @post.likes.build(user: @user)

    if @like.save
      redirect_to user_posts_path(@user)
    else
      redirect_to user_posts_path(@user), alert: 'Error creating like.'
    end
  end
end
