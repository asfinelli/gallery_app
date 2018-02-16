class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :new, :destroy]


  def new
    @post = current_user.posts.build
  end

  def index
    @posts = if params[:term]
      Post.order(created_at: :desc).where('Description ILIKE ?', "%#{params[:term.downcase]}%")

    else
      Post.order(created_at: :desc)
    end
  end

  def show
    @post = Post.where(id: params[:id])
  end


  def create
    @post = current_user.posts.build(permit_post)
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
  def permit_post
    params.require(:post).permit(:image, :description)
  end
end
