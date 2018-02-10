class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  @user = current_user
  @post = Post.where(user_id: current_user.id)
end
end
