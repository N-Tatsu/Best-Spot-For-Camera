# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
      post_images_path
  end

  def after_sign_out_path_for(resource)
      root_path
  end

  # ゲストユーザーをログイン状態後、ゲストユーザーの詳細ページへと遷移させる
  def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to user_path(user), notice: "ゲストユーザーでログインしました。"
  end



  private
  #userがアクティブであるか判断するメソッド
  def user_state
      #[処理内容１]入力されたemailアカウントから１件取得
      @user = User.find_by(email: params[:user][:email])
      #[処理内容２]アカウントが取得されなかった場合、このメソッドを終了する
      return if @user.nil?
      #[処理内容３]取得されたアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
      return unless @user.valid_password?(params[:user][:password])
      #[処理内容４]取得したアカウントのパスワードが一致 かつ ユーザーのステータスがアクティブでない場合の処理。（「！」は論理否定演算子）
      #退会したユーザーがログインできないようにする
      if @user.valid_password?(params[:user][:password]) && !@user.is_deleted
          flash[:danger] = '登録されたアカウントは退会済みです。別のメールアドレスをお使いください。'
          redirect_to new_user_session_path
      end
  end

end
