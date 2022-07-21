class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Posts.new(post_params)
    @post.author = current_user
    if @post.save
      @post.update_users_posts_counter(params[:user_id])
      redirect_to user_posts_path(@user.id)
      flash[:notice] = 'Your comment was successfully created'
    else
      redirect_to new_user_post_path(@user.id)
      flash[:notice] = 'An error has occurred while creating the post'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:posts_counter)
    @post.destroy!
    redirect_to user_posts_path(id: @author.id), notice: 'Post was deleted successfully!'
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
