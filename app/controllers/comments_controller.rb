class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post


  def create

    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  private
  def find_post
    @post = Post.where(id: params[:id])
  end
  def comment_params
    params.require(:comment).permit(:content, :user, :post)
end
