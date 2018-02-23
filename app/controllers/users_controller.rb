class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:index]


  def show
    @user = current_user
    @post = Post.where(user_id: current_user.id)
  end

  def index
    @post = Post.where(user_id: @user.id)
end

def set_user
  @user = User.find(params[:user_id])
end
