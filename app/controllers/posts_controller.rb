class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]


  def new
    @post = current_user.posts.build
  end

  def index
    @posts = if params[:term]
      Post.where('Description ILIKE ?', "%#{params[:term.downcase]}%")
    else
      Post.all
    end
  end

  def show
    @post = Post.where(id: params[:id])
  end


  def create
    @post = current_user.posts.build(permit_post)
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  private
  def permit_post
    params.require(:post).permit(:image, :description)
  end
end
