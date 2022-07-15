class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(author_id: @user.id, post_id: @post.id)

    if @like.save
      @post = Post.find(params[:post_id])
      redirect_to user_user_path(user_id: @post.author_id, id: @post.id), alert: 'An error has occurred while creating the like'
    end
  end
end
