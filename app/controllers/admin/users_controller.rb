class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "プロフィールを変更しました"
    else
      render edit
    end
  end
end


private

def user_params
  params.require(:user).permit(:image, :name, :introduction, :is_deleted)
end