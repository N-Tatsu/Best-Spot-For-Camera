class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
      @post_images = PostImage.page(params[:page]).per(10)
  end

end
