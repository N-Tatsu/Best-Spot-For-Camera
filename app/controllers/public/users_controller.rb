class Public::UsersController < ApplicationController
  
  def index
    @users = User.all 
  end
  
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  
  end

  def edit
  end
  
  def update
  end

  def unsubscribe
  end
  
  def withdraw
  end
end
