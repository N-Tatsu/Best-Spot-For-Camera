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

  def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to user_path(user), notice: "ゲストユーザーでログインしました。"
  end



  private

  def user_state
      @user = User.find_by(email: params[:user][:email])
      return if @user.nil?
      return unless @user.valid_password?(params[:user][:password])
      #退会したユーザーがログインできないようにする
      if @user.valid_password?(params[:user][:password]) && !@user.is_deleted
          flash[:danger] = '登録されたアカウントは退会済みです。別のメールアドレスをお使いください。'
          redirect_to new_user_session_path
      end
  end

# # 管理者側で退会させてあと、ログアウトが済んでいないユーザーもログアウト状態にする
#   def user_state
#   @user = User.find_by(email: params[:user][:email])
#     if @user
#       if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
#         flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
#         redirect_to new_user_registration_path
#       else
#         flash[:notice] = "項目を入力してください"
#       end
#     else
#       flash[:notice] = "該当するユーザーが見つかりません"
#     end
#   end

end
