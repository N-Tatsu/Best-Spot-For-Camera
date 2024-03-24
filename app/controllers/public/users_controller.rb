class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit,:update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
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
    @user = current_user
    if @user.update(user_params)
       redirect_to user_path(@user), notice: "プロフィールを変更しました"
    else
      flash.now[:alert] = "※プロフィールが変更できていません。"
      render "edit"
    end
  end

  def unsubscribe
    @user = User.find_by(name: params[:email])
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_image_id)  #favoritesに@userがいいねしたpost_image一覧が取得される
    @favorites_post_images = PostImage.find(favorites)
    # @post_image = PostImage.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #現在ログインしているユーザーが編集しようとしているユーザーと同じかどうかを確認する
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), notice: "ユーザー自身のプロフィールしか編集できません。"
    end
  end

  # ゲストユーザーがURLを打ち込んでも編集画面に遷移しないようにする
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
       redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
