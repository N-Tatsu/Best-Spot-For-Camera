class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  def edit
    @user = user.find(params[:id])
  end
end
