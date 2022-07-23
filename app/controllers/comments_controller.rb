class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  skip_before_action :authenticate_request
  before_action :authenticate_request, only: [:add_comment]
  protect_from_forgery with: :null_session, only: [:add_comment]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.author_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
      flash[:notice] = 'Your comment was successfully created'
    else
      render :new, alert: 'An error has occured while creating the comment'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.posts_counter -= 1
    @post.destroy!
    redirect_to user_posts_path(id: @author.id), notice: 'Post was deleted successfully!'
  end

  def comments
    post = Post.find(params[:id])

    respond_to do |format|
      format.json { render json: post.comments }
    end
  end

  def add_comment
    comment = Comment.new(author: @curr_user, post_id: params[:post_id], text: params[:text])

    respond_to do |format|
      if comment.save
        format.json { render json: comment }
      else
        format.json { render json: { success: false, message: comment.errors.full_messages } }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
